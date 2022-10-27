import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/payment_method_types.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/ui/widgets/cart/cart_card.dart';
import 'package:vf_user_flutter_new/ui/widgets/cart/no_cart_widget.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import 'confirm_order_viewmodel.dart';

class ConfirmOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmOrderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('My Order'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order details',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).primaryColor, fontSize: AppDimens.fontM, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: AppDimens.spacing,
              ),
              _buildCarts(context, model),
              _BottomWidget(
                model: model,
              ),
              // _buildNoCart(context)
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmOrderViewModel(),
    );
  }

  Widget _buildNoCart(BuildContext context) {
    return Expanded(
      child: Center(
        child: NoCartWidget(),
      ),
    );
  }

  Widget _buildCarts(BuildContext context, ConfirmOrderViewModel model) {
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
}

class _BottomWidget extends StatelessWidget {
  final ConfirmOrderViewModel model;

  _BottomWidget({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              'Add Promo Code',
              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: model.promoCode),
                onChanged: model.onChangePromoCode,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 6, 6, 10),
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  // suffixIcon: IconButton(
                  //   onPressed: () => model.onSubmitPromoCode(context),
                  //   icon: Icon(Icons.remove_red_eye_rounded),
                  // ),
                  suffixIcon: ElevatedButton(
                    onPressed: () => model.onSubmitPromoCode(context),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.green1,
                      onPrimary: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 30,
                    ),
                  ),
                ),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppDimens.spacing,
        ),
        Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Item Total',
              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM, fontWeight: FontWeight.w500),
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
          height: AppDimens.spacing,
        ),
        Divider(
          thickness: 1,
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
        _PaymentMethodSection(
          model: model,
        ),
        SizedBox(
          height: AppDimens.spacing,
        ),
        Column(
          children: model.cards
              .map(
                (card) => _PaymentItem(card, model.selectedCard, model.updatePaymentMethod),
              )
              .toList(),
        ),
        SizedBox(
          height: AppDimens.spacing,
        ),
        RoundBtnWidget(
          onPress: () => model.confirmOrder(context),
          title: 'Confirm Order',
        ),
      ],
    );
  }
}

class _PaymentMethodSection extends StatelessWidget {
  final ConfirmOrderViewModel model;

  _PaymentMethodSection({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.showAddPayment,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),
          ),
          Text(
            'Add',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Theme.of(context).primaryColor, fontSize: AppDimens.fontM, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  _PaymentItem(this.defaultValue, this.groupValue, this.onChange);
  final CustomerCard defaultValue;
  final CustomerCard groupValue;
  final Function(CustomerCard) onChange;

  @override
  Widget build(BuildContext context) {
    String description = '**** **** **** ' + defaultValue.card.last4;
    String asset = '';
    switch (defaultValue.type) {
      case 'visa':
        asset = AppAssets.visaIcon;
        break;
      case 'playStore':
        asset = AppAssets.storeIcon;
        break;
      default:
        asset = AppAssets.visaIcon;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusS)),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        title: Text(description),
        leading: Image.asset(asset),
        trailing: Radio<CustomerCard>(
          focusColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
          // fillColor: MaterialStateProperty(),
          value: defaultValue,
          groupValue: groupValue,
          onChanged: (CustomerCard value) {
            onChange(value);
          },
        ),
      ),
    );
  }
}
