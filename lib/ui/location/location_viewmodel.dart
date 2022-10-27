import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/models/home/place_model.dart';
import 'package:vf_user_flutter_new/routes/app_routes.dart';
import 'package:vf_user_flutter_new/services/location_service.dart';
import 'package:vf_user_flutter_new/services/navigation/navigation_service.dart';

import '../../locator.dart';

class LocationViewModel extends BaseViewModel {
  final _navSvc = locator<NavigationService>();
  final _locationSvc = locator<LocationService>();
  final Completer<GoogleMapController> mapController = Completer();
  final TextEditingController searchController = TextEditingController();

  List<PlaceModel> searchResults = [];

  void getPlacePredictions(String searchQuery) async {
    if (searchController.text.isNotEmpty) {
      List<PlaceModel> newPredictions = await _locationSvc.getSearchResults(searchQuery);
      searchResults.clear();
      searchResults = newPredictions;
      notifyListeners();
    } else {
      searchResults.clear();
      notifyListeners();
    }
  }

  void onClear() {
    searchController.clear();
    searchResults.clear();

    notifyListeners();
  }

  void onPressPlace(PlaceModel p, bool isFirstLaunch) async {
    try {
      await _locationSvc.getLocationDetail(p);
    } finally {
      handleNav(isFirstLaunch);
    }
  }

  void onUseCurrentLocation(bool isFirstLaunch) async {
    try {
      await _locationSvc.useCurrentLocation();
    } finally {
      handleNav(isFirstLaunch);
    }
  }

  void handleNav(bool isFirstLaunch) {
    if (isFirstLaunch) {
      _navSvc.appNavigatorKey.currentState.pushReplacementNamed(AppRoutes.appRoot);
    } else {
      _navSvc.popup();
    }
  }
}
