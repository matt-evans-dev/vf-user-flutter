import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/user/user_location_mdel.dart';
import 'package:vf_user_flutter_new/services/location_service.dart';

import '../../../locator.dart';

class AddressBarWidget extends HookWidget {
  final Function showLocationPickerView;
  AddressBarWidget({@required this.showLocationPickerView});

  @override
  Widget build(BuildContext context) {
    final _locationSvc = locator<LocationService>();
    var currLocation = useStream<UserLocationModel>(_locationSvc.curLocationStream, initialData: UserLocationModel()).data;

    return GestureDetector(
      onTap: () => showLocationPickerView(context),
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
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
              'My Location',
              style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: AppDimens.spacing,
            ),
            Flexible(
              child: Text(
                currLocation.location,
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
