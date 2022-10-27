import 'package:dio/dio.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vf_user_flutter_new/constants/config.dart';
import 'package:vf_user_flutter_new/models/home/place_model.dart';
import 'package:vf_user_flutter_new/models/user/user_location_mdel.dart';
import 'package:vf_user_flutter_new/services/loggr.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';

import '../locator.dart';

class LocationService {
  Location location = Location();
  BehaviorSubject<UserLocationModel> _currentLocation = BehaviorSubject.seeded(UserLocationModel());
  final SharedPreferenceService _sharedPrefSvc;

  LocationService(this._sharedPrefSvc);

  Future<LocationService> init() async {
    String currLocation = await _sharedPrefSvc.location;
    if (currLocation != null) {
      var latitude = await _sharedPrefSvc.latitude;
      var longitude = await _sharedPrefSvc.longitude;

      UserLocationModel value = UserLocationModel(
        latitude: latitude,
        longitude: longitude,
        location: currLocation,
      );

      // Update the current location.
      updateCurrentLocation(value);
    }

    return this;
  }

  UserLocationModel get currentLocation => _currentLocation.value;
  Stream<UserLocationModel> get curLocationStream => _currentLocation.stream;

  // Update the current location value.
  void updateCurrentLocation(UserLocationModel value) {
    // Trigger the event for updating the location
    _currentLocation.add(value);
    // Save location to the local storage
    saveToLocal(value);
  }

  // Save location to the local storage.
  void saveToLocal(UserLocationModel value) {
    var sharedPrefService = locator<SharedPreferenceService>();
    sharedPrefService.saveLatitude(value.latitude);
    sharedPrefService.saveLongitude(value.longitude);
    sharedPrefService.saveLocation(value.location);
  }

  // Get predictions of place by using google place api.
  Future<List<PlaceModel>> getSearchResults(String searchQuery) async {
    String url = AppConfig.GOOGLE_PLACE_PREDICT_URL + '?input=$searchQuery&key=${AppConfig.GOOGLE_MAP_API_KEY}';
    final response = await Dio().get(url);
    List<PlaceModel> places = List.from(response.data['predictions']).map((item) => PlaceModel.fromJson(item)).toList();
    return places;
  }

  // Get detail of place by using google place id.
  Future<void> getLocationDetail(PlaceModel place) async {
    String url = AppConfig.GOOGLE_PLACE_DETAIL_URL + '?place_id=${place.placeId}&key=${AppConfig.GOOGLE_MAP_API_KEY}';
    final response = await Dio().get(url);
    double lat = response.data['result']['geometry']['location']['lat'];
    double lng = response.data['result']['geometry']['location']['lng'];
    // logger.i(lat);

    UserLocationModel newLocation = UserLocationModel(
      location: place.description,
      latitude: lat,
      longitude: lng,
    );

    // Update the current location.
    updateCurrentLocation(newLocation);
  }

  // Use current location
  Future<void> useCurrentLocation() async {
    PermissionStatus _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.GRANTED) {
      LocationData userLocation = await location.getLocation();
      logger.i(userLocation);
      // Get address with coordinates
      final coordinates = Coordinates(userLocation.latitude, userLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;

      UserLocationModel value = UserLocationModel(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        location: first.addressLine,
        // location: 'Postal code 92656',
      );
      // Update the current location.
      updateCurrentLocation(value);
    }
  }
}
