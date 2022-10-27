import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/food_all_info_types.dart';

class FoodAllIconInfoWidget extends StatelessWidget {
  final FoodAllInfoTypes type;
  final String data;
  FoodAllIconInfoWidget({@required this.type, this.data});

  @override
  Widget build(BuildContext context) {
    String asset;
    switch (type) {
      case FoodAllInfoTypes.food:
        asset = AppAssets.foodIcon;
        break;
      case FoodAllInfoTypes.travel:
        asset = AppAssets.travelIcon;
        break;
      case FoodAllInfoTypes.price:
        asset = AppAssets.priceIcon;
        break;
      default:
        break;
    }

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            width: AppDimens.foodAllIconWidth,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: AppDimens.spacingXS,
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
