import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/ui/cart/order_success/order_success_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

class OrderSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderSuccessViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.orderImg),
                    SizedBox(
                      height: AppDimens.spacing,
                    ),
                    Text(
                      'Thank you for your order!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: AppDimens.spacing,
                    ),
                    Text(
                      'Your order was placed successfully.\nThanks for using our services\nEnjoy your food!',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              RoundBtnWidget(
                onPress: model.shoBrowsingFood,
                title: 'Continue Browsing',
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => OrderSuccessViewModel(),
    );
  }
}
