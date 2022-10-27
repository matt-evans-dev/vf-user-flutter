import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';

class NoCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.shoppingCartImg),
          SizedBox(
            height: AppDimens.spacing,
          ),
          Text(
            'Your cart is empty!\nGo ahead, order some items',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
