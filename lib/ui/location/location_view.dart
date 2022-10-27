import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/ui/location/location_viewmodel.dart';

class LocationView extends StatelessWidget {
  final bool isFirstLaunch;
  LocationView({this.isFirstLaunch = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Address',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: !isFirstLaunch,
        ),
        body: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(left: AppDimens.screenPadding, right: AppDimens.screenPadding, top: AppDimens.screenPadding),
              padding: EdgeInsets.all(AppDimens.screenPadding),
              color: Colors.transparent,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => model.onUseCurrentLocation(isFirstLaunch),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).primaryColor,
                          size: AppDimens.locationIconSize,
                        ),
                        SizedBox(
                          width: AppDimens.spacing,
                        ),
                        Text(
                          'Use Current Location',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.green1,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.green1,
                                decorationThickness: 1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppDimens.spacing,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: model.searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Location',
                            border: InputBorder.none,
                          ),
                          onChanged: model.getPlacePredictions,
                        ),
                      ),
                      Visibility(
                        visible: (model.searchController.text.isNotEmpty),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () => model.onClear,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: AppValues.googlePlex,
                    onMapCreated: (GoogleMapController controller) {
                      model.mapController.complete(controller);
                    },
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     padding: EdgeInsets.all(AppDimens.spacingL),
                  //     child: RoundBtnWidget(
                  //       title: 'Save',
                  //       onPress: () {},
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(AppDimens.radiusN),
                  //         topRight: Radius.circular(AppDimens.radiusN),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      itemCount: model.searchResults.length,
                      itemBuilder: (context, index) => GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          child: Text(model.searchResults[index].description),
                        ),
                        onTap: () => model.onPressPlace(model.searchResults[index], isFirstLaunch),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
      viewModelBuilder: () => LocationViewModel(),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
