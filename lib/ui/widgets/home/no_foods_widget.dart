import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';

class NoFoodsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.homeBlankImg),
          SizedBox(
            height: AppDimens.spacing,
          ),
          Text(
            AppStrings.homeBlank,
          )
        ],
      ),
    );
  }
}
