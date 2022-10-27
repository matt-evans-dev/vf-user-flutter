import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/payment_method_types.dart';
import 'package:vf_user_flutter_new/ui/cart/add_payment_view/add_payment_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';
import '../add_card/add_card_view.dart';

class AddPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add Payment'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            children: [
              _PaymentItem(
                PaymentMethodTypes.credit,
                model.character,
                model.updatePaymentMethod,
              ),
              Divider(
                thickness: 1,
              ),
              _PaymentItem(
                PaymentMethodTypes.paypal,
                model.character,
                model.updatePaymentMethod,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundBtnWidget(
                    onPress: model.showAddPayment,
                    title: 'Next',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AddPaymentViewModel(),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  _PaymentItem(this.defaultValue, this.groupValue, this.onChange);
  final PaymentMethodTypes defaultValue;
  final PaymentMethodTypes groupValue;
  final Function(PaymentMethodTypes) onChange;

  @override
  Widget build(BuildContext context) {
    String description = '';
    String asset = '';
    switch (defaultValue) {
      case PaymentMethodTypes.credit:
        description = 'Credit';
        asset = AppAssets.creditIcon;
        break;
      case PaymentMethodTypes.paypal:
        description = 'Paypal';
        asset = AppAssets.paypalIcon;
        break;
      default:
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusS)),
      child: ListTile(
        title: Text(description),
        leading: Image.asset(asset),
        trailing: Radio<PaymentMethodTypes>(
          focusColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
          value: defaultValue,
          groupValue: groupValue,
          onChanged: (PaymentMethodTypes value) {
            onChange(value);
          },
        ),
      ),
    );
  }
}
