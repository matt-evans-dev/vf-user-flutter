import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';
import 'package:vf_user_flutter_new/ui/widgets/food_detail/food_detail_card_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import '../count_btn_widget.dart';

class FoodDetailCardWidget extends StatelessWidget {
  final ProductModel data;
  FoodDetailCardWidget({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodDetailCardViewModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        onTap: model.showFoodDetailView,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppDimens.spacingM),
          margin: EdgeInsets.only(bottom: AppDimens.spacingL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: AppDimens.foodDetailImgWidth,
                height: AppDimens.foodDetailImgHeight,
                margin: EdgeInsets.only(right: AppDimens.spacingL),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage(AppAssets.foodImg),
                    image: NetworkImage(data.image[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(AppDimens.foodDetailImgWidth / 2),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: AppDimens.spacing,
                    ),
                    Text(
                      data.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: AppDimens.spacing,
                    ),
                    Text(
                      '${data.price} USD',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Theme.of(context).accentColor, fontSize: AppDimens.fontM, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: AppDimens.spacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CountBtnWidget(
                          quantity: model.quantity,
                          onIncrease: () => model.onIncrease(data.quantity),
                          onDecrease: model.onDecrease,
                        ),
                        RoundBtnWidget(
                          onPress: () => model.onAdd(data),
                          title: !model.existInCart ? 'Add to' : 'In',
                          width: 100,
                          height: 35,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusN)),
          ),
        ),
      ),
      viewModelBuilder: () => FoodDetailCardViewModel(data: data),
    );
  }
}
