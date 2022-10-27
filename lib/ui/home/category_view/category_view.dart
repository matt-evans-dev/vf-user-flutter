import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_detail/food_detail_card.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/no_foods_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/progress_indicator_widget.dart';

import '../../../locator.dart';
import 'category_view_viewmodel.dart';

class CategoryView extends StatelessWidget {
  final CategoryInfo data;
  CategoryView({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: !model.isLoading
            ? Stack(
                children: [
                  _buildHeader(context),
                  _Foods(data: model.foods),
                ],
              )
            : ProgressIndicatorWidget(),
      ),
      // viewModelBuilder: () => CategoryViewModel(),
      viewModelBuilder: () => locator<CategoryViewModel>(),
      disposeViewModel: false,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.screenPadding),
      width: AppDimens.foodAllHeaderWidth,
      height: AppDimens.foodDetailHeaderHeight,
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
                  data.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Icon(
                  Icons.favorite_outline_sharp,
                  color: Color(0xFFFBA83C),
                  size: AppDimens.favouriteIconSize,
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(data.img),
          // image: NetworkImage(merchantData.profilePic),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Foods extends StatelessWidget {
  final List<ProductModel> data;
  _Foods({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryViewModel>.reactive(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.only(left: AppDimens.screenPadding, top: AppDimens.screenPadding, right: AppDimens.screenPadding),
        margin: EdgeInsets.only(top: AppDimens.foodDetailHeaderHeight - AppDimens.spacingL),
        child: Column(
          children: [
            Text(
              'Foods',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: AppDimens.spacing,
            ),
            Expanded(
              child: data.length > 0
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) => FoodDetailCardWidget(
                        data: data[i],
                      ),
                    )
                  : NoFoodsWidget(),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.radiusL),
            topRight: Radius.circular(AppDimens.radiusL),
          ),
        ),
      ),
      viewModelBuilder: () => locator<CategoryViewModel>(),
      disposeViewModel: false,
    );
  }
}
