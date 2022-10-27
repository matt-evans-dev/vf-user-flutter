import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/payment_method_types.dart';
import 'package:vf_user_flutter_new/models/customer_card/customer_card.dart';

import 'manage_payment_viewmodel.dart';

class ManagePaymentView extends StatelessWidget {
  static const String id = 'manage_payment';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManagePaymentViewModel>.reactive(
        viewModelBuilder: () => ManagePaymentViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Theme.of(context).accentColor,
                          onPressed: () => model.goBack(context),
                        ),
                        SizedBox(width: 40.0),
                        Text(
                          'Manage payment',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Choose your payment method',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: model.cards
                          .map(
                            (card) => _PaymentItem(PaymentMethodTypes.visa, model.character, model.updatePaymentMethod, card),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 30.0),
                    Divider(),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () => model.goToAddPayment(context),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white60,
                            onPrimary: AppColors.green1,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/icons/ic_credit.png'),
                            Text(
                              'Add new payment method',
                              style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.green1),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ));
  }
}

class _PaymentItem extends StatelessWidget {
  _PaymentItem(this.defaultValue, this.groupValue, this.onChange, this.card);
  final PaymentMethodTypes defaultValue;
  final PaymentMethodTypes groupValue;
  final Function(PaymentMethodTypes) onChange;
  final CustomerCard card;

  @override
  Widget build(BuildContext context) {
    String description = '**** **** **** ' + card.card.last4;
    String asset = '';
    switch (card.type) {
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
        trailing: Radio<PaymentMethodTypes>(
          focusColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
          // fillColor: MaterialStateProperty(),
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
