import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/ui/cart/cart/cart_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/widgets/cart/cart_card.dart';
import 'package:vf_user_flutter_new/ui/widgets/cart/no_cart_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import '../../../locator.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: Container(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            children: [
              Center(
                child: Text(
                  'My Cart',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              _buildCarts(context, model),
              _BottomWidget(),
              // _buildNoCart(context)
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<CartViewModel>(),
    );
  }

  Widget _buildCarts(BuildContext context, CartViewModel model) {
    if (model.cartIsEmpty) {
      return _buildNoCart(context);
    }
    List<CartCard> itemsList = [];
    model.items.asMap().forEach((int merchantIdx, MerchantCart mCart) {
      mCart.merchantCartItems.asMap().forEach((int idx, CartItemModel cartItem) {
        itemsList.add(CartCard(
          data: cartItem,
          index: idx,
          merchantIdx: merchantIdx,
        ));
      });
    });
    return Expanded(
      child: Column(
        children: itemsList,
      ),
    );
  }

  Widget _buildNoCart(BuildContext context) {
    return Expanded(
      child: Center(
        child: NoCartWidget(),
      ),
    );
  }
}

class _BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      builder: (context, model, child) => Column(
        children: [
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: AppDimens.spacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '${model.totalPrice} USD',
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
            onPress: () => model.showConfirmOrder(context),
            title: 'Make Order',
          ),
          SizedBox(
            height: AppDimens.spacing,
          ),
          RoundBtnWidget(
            bgColor: Theme.of(context).backgroundColor,
            txtColor: Theme.of(context).primaryColor,
            onPress: model.showContinue,
            title: 'Continue Shopping',
          ),
        ],
      ),
      viewModelBuilder: () => CartViewModel(),
    );
  }
}
