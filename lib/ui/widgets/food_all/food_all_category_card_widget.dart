import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/app_theme.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/home/food_all/food_all_viewmodel.dart';

class FoodAllCategoryWidget extends StatelessWidget {
  final CategoryInfo data;
  FoodAllCategoryWidget({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: AppDimens.foodAllCardWidth,
        height: AppDimens.foodAllCardHeight,
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(data.img),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusN),
          gradient: kCardGradient,
        ),
        child: Center(
          child: Text(
            data.name,
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
