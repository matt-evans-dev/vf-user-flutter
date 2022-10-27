import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/ui/onboarding/forgot_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeView extends StatelessWidget {
  static const String id = 'verification_code_view';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // ignore: close_sinks
    StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
    return ViewModelBuilder<ForgotViewModel>.reactive(
        viewModelBuilder: () => locator<ForgotViewModel>(),
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 100 / 64,
                        child: new Container(
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.bottomCenter,
                            image: new AssetImage('assets/images/mix_logo.png'),
                          )),
                        )),
                    SizedBox(height: 48.0),
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
                          'Forgot Password',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Enter 6-digit verification code that was sent to your mobile number',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).accentColor, height: 1.8),
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          obscuringCharacter: '*',
                          // obscuringWidget: FlutterLogo(
                          //   size: 24,
                          // ),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v == null || v.isEmpty || v.length < 6) {
                              return "Recovery code should be 6 letters";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveFillColor: Theme.of(context).cardColor,
                            inactiveColor: Theme.of(context).cardColor,
                            activeFillColor: AppColors.green1,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: model.onChangeCode,
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        if (model.currentText == null || model.currentText.length != 6) {
                          errorController.add(ErrorAnimationType.shake);
                          return;
                        }
                        model.onContinue(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.green1,
                        onPrimary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.fromLTRB(13, 13, 13, 13),
                      ),
                      child: Text(
                        'Continue',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => {},
                          child: Text("Re-send code", style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1)),
                        ),
                        TextButton(
                          onPressed: () => model.goBack(context),
                          child: Text("Change phone number", style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
