import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/ui/cart/add_card/add_card_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import '../order_success/order_success_view.dart';

class AddCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCardViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add your card'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: model.cardNumber,
              expiryDate: model.expiryDate,
              cardHolderName: model.cardHolderName,
              cvvCode: model.cvvCode,
              showBackView: model.isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              cardBgColor: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: model.formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: model.cardNumber,
                      cvvCode: model.cvvCode,
                      cardHolderName: model.cardHolderName,
                      expiryDate: model.expiryDate,
                      themeColor: Theme.of(context).accentColor,
                      textColor: Theme.of(context).accentColor,
                      cardNumberDecoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      expiryDateDecoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      cvvCodeDecoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      cardHolderDecoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      onCreditCardModelChange: model.updateCardInfo,
                    ),
                    Container(
                      padding: EdgeInsets.all(AppDimens.screenPadding),
                      child: RoundBtnWidget(
                        title: 'Add',
                        onPress: () {
                          if (model.formKey.currentState.validate()) {
                            model.addCard(context);
                          }
                        },
                      ),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     primary: const Color(0xff1b447b),
                    //   ),
                    //   child: Container(
                    //     margin: EdgeInsets.all(8),
                    //     child: Text(
                    //       'Validate',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontFamily: 'halter',
                    //         fontSize: 14,
                    //         package: 'flutter_credit_card',
                    //       ),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     if (model.formKey.currentState.validate()) {
                    //       print('valid!');
                    //     } else {
                    //       print('invalid!');
                    //     }
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AddCardViewModel(),
    );
  }
}
