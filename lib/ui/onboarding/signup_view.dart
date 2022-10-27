import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/ui/onboarding/signup_viewmodel.dart';

class SignUpView extends StatelessWidget {
  static const String id = 'signup_view';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // ignore: close_sinks
    StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // Image.asset('assets/images/mix_logo.png'),
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
                        SizedBox(height: 28.0),
                        Text(
                          'Create an account',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: model.otpSent
                          ? Padding(
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
                                onChanged: model.onChangeOTP,
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                            )
                          : Column(
                              children: [
                                TextFormField(
                                  controller: TextEditingController(text: model.firstName),
                                  onChanged: model.onChangeFirstName,
                                  validator: model.emptyValidator,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'First Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                                    hintStyle: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: TextEditingController(text: model.lastName),
                                  onChanged: model.onChangeLastName,
                                  validator: model.emptyValidator,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Last Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                                    hintStyle: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(height: 12.0),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                        width: 120,
                                        child: DropdownButtonFormField(
                                          onChanged: model.onChangeCountryCode,
                                          validator: model.emptyValidator,
                                          items: AppStrings.countryCodes.map((String category) {
                                            return new DropdownMenuItem(
                                                value: category,
                                                child: Row(
                                                  children: <Widget>[
                                                    // Icon(Icons.star),
                                                    Text(category),
                                                  ],
                                                ));
                                          }).toList(),
                                          value: model.countryCode,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintText: 'Code',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(14, 11, 11, 10),
                                            hintStyle: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          style: Theme.of(context).textTheme.subtitle2,
                                        )),
                                    SizedBox(width: 13.0),
                                    Expanded(
                                      child: TextFormField(
                                        controller: TextEditingController(text: model.phoneNumber),
                                        onChanged: model.onChangePhoneNumber,
                                        validator: model.emptyValidator,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintText: 'Mobile number',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                                          hintStyle: Theme.of(context).textTheme.subtitle2,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: TextEditingController(text: model.email),
                                  onChanged: model.onChangeEmail,
                                  validator: model.emailValidator,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                                    hintStyle: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(height: 12.0),
                                TextFormField(
                                  controller: TextEditingController(text: model.password),
                                  onChanged: model.onChangePassword,
                                  validator: model.emptyValidator,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                                    hintStyle: Theme.of(context).textTheme.subtitle2,
                                    suffixIcon: IconButton(
                                      onPressed: model.togglePasswordSecure,
                                      icon: model.passwordSecure ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  obscureText: model.passwordSecure,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: 12.0),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.8),
                        children: <TextSpan>[
                          TextSpan(text: 'by clicking Sign Up, you agree to our '),
                          TextSpan(
                              text: ' Terms and Conditions ',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green1),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(AppStrings.termsURL);
                                }),
                          TextSpan(text: ' and '),
                          TextSpan(
                              text: ' Privacy Statement ',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green1),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(AppStrings.policyURL);
                                }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.onSignUp(context, errorController);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.green1,
                          onPrimary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),
                      child: Text(
                        model.otpSent ? 'Verify codes' : 'Sign Up',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account? ", style: Theme.of(context).textTheme.subtitle2),
                        TextButton(
                          onPressed: () => model.goToLogin(context),
                          child: Text(
                            "Log in",
                            style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
            ));
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
