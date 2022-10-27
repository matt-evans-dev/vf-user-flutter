import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/app_theme.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/home/food_all/food_all_viewmodel.dart';

class FoodAllCardWidget extends StatelessWidget {
  final ProductModel data;
  FoodAllCardWidget({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodAllViewModel>.nonReactive(
      builder: (context, model, child) => GestureDetector(
        onTap: model.showFoodCollectionView,
        child: Container(
          width: AppDimens.foodAllCardWidth,
          height: AppDimens.foodAllCardHeight,
          margin: EdgeInsets.only(bottom: AppDimens.spacingL),
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: AssetImage(AppAssets.foodImg),
              image: NetworkImage(data.image[0]),
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
      ),
      viewModelBuilder: () => FoodAllViewModel(),
    );
  }
}
