import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/food_all_info_types.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/home/food_all/food_all_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_all/food_all_card_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_all/food_all_category_card_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_all/food_all_icon_info_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';

class FoodAllView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodAllViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: Stack(
          children: [
            _buildHeader(context),
            // _buildFoods(context, model.products),
            _buildCategories(context),
          ],
        ),
      ),
      viewModelBuilder: () => FoodAllViewModel(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.screenPadding),
      width: AppDimens.foodAllHeaderWidth,
      height: AppDimens.foodAllHeaderHeight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppDimens.favouriteIconSize,
                ),
                Text(
                  'Pizza Food',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Icon(
                  Icons.favorite_outline_sharp,
                  color: Color(0xFFFBA83C),
                  size: AppDimens.favouriteIconSize,
                ),
              ],
            ),
            SizedBox(
              height: AppDimens.spacing,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FoodAllIconInfoWidget(
                  type: FoodAllInfoTypes.food,
                  data: 'Italian cuisine',
                ),
                FoodAllIconInfoWidget(
                  type: FoodAllInfoTypes.travel,
                  data: '30-60 min',
                ),
                FoodAllIconInfoWidget(
                  type: FoodAllInfoTypes.food,
                  data: '18-50 USD',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).primaryColor,
                  size: AppDimens.locationIconSize,
                ),
                Text(
                  '14701 Harvard Ave - Irvine CA',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.foodImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget _buildFoods(BuildContext context, List<ProductModel> foods) {
  //   return Container(
  //     padding: EdgeInsets.only(left: AppDimens.screenPadding, top: AppDimens.screenPadding, right: AppDimens.screenPadding),
  //     margin: EdgeInsets.only(top: AppDimens.foodAllHeaderHeight - AppDimens.spacingL),
  //     child: ListView.builder(
  //       itemCount: foods.length,
  //       itemBuilder: (context, i) => FoodAllCardWidget(data: foods[i]),
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(AppDimens.radiusL),
  //         topRight: Radius.circular(AppDimens.radiusL),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCategories(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppDimens.screenPadding, top: AppDimens.screenPadding, right: AppDimens.screenPadding),
      margin: EdgeInsets.only(top: AppDimens.foodAllHeaderHeight - AppDimens.spacingL),
      child: ListView.builder(
        itemCount: AppValues.categories.length,
        itemBuilder: (context, i) => FoodAllCategoryWidget(
          data: AppValues.categories[i],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.radiusL),
          topRight: Radius.circular(AppDimens.radiusL),
        ),
      ),
    );
  }
}
