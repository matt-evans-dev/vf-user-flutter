import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/ui/account/account_viewmodel.dart';

class ManageAccountView extends StatelessWidget {
  static const String id = 'manage_account';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // ignore: close_sinks
    StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
    return ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: ListView(
                  // physics: const NeverScrollableScrollPhysics(),
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
                          'Manage account',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Personal information',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 20.0),
                          // TextField(
                          //   controller: TextEditingController(text: model.userDetail.userName),
                          //   onChanged: model.onChangeUserName,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     hintText: 'User Name',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide(
                          //         width: 0,
                          //         style: BorderStyle.none,
                          //       ),
                          //     ),
                          //     contentPadding: EdgeInsets.fromLTRB(15, 11, 11, 15),
                          //     hintStyle: Theme.of(context).textTheme.subtitle2,
                          //   ),
                          //   style: Theme.of(context).textTheme.subtitle2,
                          // ),
                          // SizedBox(height: 14.0),
                          TextFormField(
                            controller: TextEditingController(text: model.userDetailEdited.email),
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
                          SizedBox(height: 14.0),
                          TextFormField(
                              controller: TextEditingController(text: model.userDetailEdited.mobile),
                              onChanged: model.onChangeMobile,
                              validator: model.mobileValidator,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Phone number',
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
                              style: Theme.of(context).textTheme.subtitle2),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                            child: model.otpSent
                                ? PinCodeTextField(
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
                                  )
                                : null,
                          ),
                          Text(
                            'Change password',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: TextEditingController(text: model.currentPassword),
                            onChanged: model.onChangeCurrentPassword,
                            validator: model.currentPasswordValidator,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Current password',
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
                                onPressed: model.onToggleCurrentPasswordSecure,
                                icon: model.currentPasswordSecure ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.visibility_off),
                              ),
                            ),
                            obscureText: model.currentPasswordSecure,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: TextEditingController(text: model.newPassword),
                            onChanged: model.onChangeNewPassword,
                            validator: model.newPasswordValidator,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'New password',
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
                                onPressed: model.onToggleNewPasswordSecure,
                                icon: model.newPasswordSecure ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.visibility_off),
                              ),
                            ),
                            obscureText: model.newPasswordSecure,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: TextEditingController(text: model.confirmPassword),
                            onChanged: model.onChangeConfirmPassword,
                            validator: model.confirmPasswordValidator,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Confirm password',
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
                                onPressed: model.onToggleConfirmPasswordSecure,
                                icon: model.confirmPasswordSecure ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.visibility_off),
                              ),
                            ),
                            obscureText: model.confirmPasswordSecure,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            model.onSave(context, errorController);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.green1,
                            onPrimary: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),
                        child: Text('Save changes', style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white))),
                  ],
                ),
              ),
            ));
  }
}
