import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/search_filter.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/ui/widgets/explore/explore_card_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_detail/food_detail_card.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/address_bar_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/category_card_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/search_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/progress_indicator_widget.dart';

import '../../../locator.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: AppBarWidget(),
          ),
          body: model.isLoading
              ? ProgressIndicatorWidget()
              : Container(
                  padding: EdgeInsets.only(left: AppDimens.screenPadding, right: AppDimens.screenPadding, top: AppDimens.screenPadding),
                  child: Column(
                    children: [
                      AddressBarWidget(
                        showLocationPickerView: model.showLocationPickerView,
                      ),
                      SearchBarWidget(),
                      buildFilter(context, model.kitchenQuery),
                      if (model.searchFilter == null)
                        Expanded(
                          child: ListView(
                            children: [
                              _Categories('We Recommend', true),
                              _Categories('Special Offers', false),
                            ],
                          ),
                        ),
                      if (model.searchFilter == SearchFilter.Foods)
                        Expanded(
                          child: ListView.builder(
                            itemCount: model.productResults.length,
                            itemBuilder: (context, i) => FoodDetailCardWidget(
                              data: model.productResults[i],
                            ),
                          ),
                        ),
                      if (model.searchFilter == SearchFilter.Restaurants)
                        Expanded(
                          child: ListView.builder(
                            itemCount: model.restaurantResults.length,
                            itemBuilder: (context, i) => ExploreCardWidget(
                              data: model.restaurantResults[i],
                              onPress: () => model.showFoodCollectionView(model.restaurantResults[i]),
                            ),
                          ),
                        ),

                      // DO NOT DELETE THIS SECTION.
                      // Expanded(
                      //   child: model.products.length != 0
                      //       ? ListView(
                      //           children: [
                      //             _buildFoods(context, 'We', model.products, model.showFoodCollectionView),
                      //             // _buildFoods(context, 'Special', model.products, model.showFoodCollectionView),
                      //           ],
                      //         )
                      //       : NoFoodsWidget(),
                      // )
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => locator<HomeViewModel>(),
      disposeViewModel: false,
    );
  }

  Widget buildFilter(BuildContext context, String selCountry) {
    return Container(
      height: AppDimens.flBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _FilterItem(AppStrings.flAll, AppAssets.flAllIcon),
          _FilterItem(AppStrings.flAmerican, AppAssets.flAmericanIcon),
          _FilterItem(AppStrings.flMexican, AppAssets.flMexicanIcon),
          _FilterItem(AppStrings.flItalian, AppAssets.flItalianIcon),
          _FilterItem(AppStrings.flJapanese, AppAssets.flJapaneseIcon),
        ],
      ),
    );
  }

  // DO NOT DELETE THIS CODE
  // Widget _buildFoods(BuildContext context, String title, List<ProductModel> foods, Function showFoodCollectionView) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: AppDimens.spacingL),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style: Theme.of(context).textTheme.headline6,
  //             ),
  //             _ViewAllButton(),
  //           ],
  //         ),
  //         SizedBox(
  //           height: AppDimens.spacing,
  //         ),
  //         Container(
  //           width: double.infinity,
  //           height: AppDimens.homeCardHeight,
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: foods.length,
  //             itemBuilder: (context, i) => HomeCardWidget(
  //               data: foods[i],
  //               showFoodCollectionView: showFoodCollectionView,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class _Categories extends StatelessWidget {
  final String title;
  final bool firstRow;
  _Categories(this.title, this.firstRow);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        height: 200,
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                _ViewAllButton(),
              ],
            ),
            SizedBox(
              height: AppDimens.spacing,
            ),
            Container(
              width: double.infinity,
              height: AppDimens.homeCardHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: firstRow ? 4 : 3,
                itemBuilder: (context, i) => CategoryCardWidget(
                  data: AppValues.categories[firstRow ? i : 4 + i],
                  onPress: model.showCategoryView,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      disposeViewModel: false,
    );
  }
}

class _ViewAllButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          model.showFoodAllView();
        },
        child: Text(
          'View all',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      disposeViewModel: false,
    );
  }
}

class _FilterItem extends StatelessWidget {
  final String foodName;
  final String foodAsset;
  _FilterItem(this.foodName, this.foodAsset);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        onTap: () => model.changeCountryQuery(foodName),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: AppDimens.spacingXS),
              child: Image.asset(foodAsset),
              width: AppDimens.flIconBtn,
              height: AppDimens.flIconBtn,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.flIconBtn / 2),
                color: foodName == model.kitchenQuery ? AppColors.grey1 : Theme.of(context).cardColor,
              ),
            ),
            Text(
              foodName,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      disposeViewModel: false,
    );
  }
}
