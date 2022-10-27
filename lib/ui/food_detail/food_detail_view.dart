import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/widgets/count_btn_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import 'food_detail_viewmodel.dart';

class FoodDetailView extends StatelessWidget {
  final ProductModel data;
  FoodDetailView({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodDetailViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _buildHeader(context, data.name, data.merchant.name, data.merchant.id, model.showMerchantFoods),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 75),
                child: Container(
                  padding: EdgeInsets.all(AppDimens.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          // child: Image.asset(
                          //   AppAssets.foodImg,
                          //   width: AppDimens.addToImgWidth,
                          //   height: AppDimens.addToImgHeight,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.network(
                            data.image[0],
                            width: AppDimens.addToImgWidth,
                            height: AppDimens.addToImgHeight,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(AppDimens.addToImgHeight / 2),
                        ),
                      ),
                      SizedBox(
                        height: AppDimens.spacingL,
                      ),
                      Text(
                        'Ground tomatoes, mozzarella, marinated spicy eggplant by homemade Italian recipe, salami Pepperoni, mozzarella and Parmesan cheese',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM),
                      ),
                      SizedBox(
                        height: AppDimens.spacingL,
                      ),
                      Text(
                        'Total weight - 580g.',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: AppDimens.spacingL,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountBtnWidget(
                            quantity: model.quantity,
                            onIncrease: () => model.onIncrease(data.quantity),
                            onDecrease: model.onDecrease,
                            bgColor: Theme.of(context).secondaryHeaderColor,
                            color: Theme.of(context).accentColor,
                          ),
                          Text(
                            '${data.price * model.quantity} USD',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Theme.of(context).primaryColor, fontSize: AppDimens.fontM, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppDimens.spacingL,
                      ),
                      RoundBtnWidget(
                        onPress: () => model.onAdd(data),
                        title: !model.existInCart ? 'Add to' : 'In',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => FoodDetailViewModel(data: data),
    );
  }

  Widget _buildHeader(BuildContext context, String foodName, String merchantName, String merchantId, Function showMerchant) {
    return Container(
      padding: EdgeInsets.all(AppDimens.screenPadding),
      width: AppDimens.addToHeaderWidth,
      height: AppDimens.addToHeaderHeight,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppDimens.radiusN),
          bottomLeft: Radius.circular(AppDimens.radiusN),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppDimens.favouriteIconSize,
              ),
              Text(
                foodName,
                style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.black1),
              ),
              Container(
                width: AppDimens.favouriteIconSize,
              ),
            ],
          ),
          SizedBox(
            height: AppDimens.spacing,
          ),
          Center(
            child: GestureDetector(
              onTap: showMerchant,
              child: Text(
                'From $merchantName',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.green1,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.green1,
                      decorationThickness: 1,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
