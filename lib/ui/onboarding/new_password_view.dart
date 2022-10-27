import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/ui/onboarding/forgot_viewmodel.dart';

class NewPasswordView extends StatelessWidget {
  static const String id = 'new_password_view';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: TextEditingController(text: model.password),
                            onChanged: model.onChangePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
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
                                icon: Icon(Icons.remove_red_eye_rounded),
                              ),
                            ),
                            obscureText: model.passwordSecure,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: TextEditingController(text: model.confirmPassword),
                            onChanged: model.onChangeConfirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (model.confirmPassword != model.password) {
                                return 'Password is not matched';
                              }
                              return null;
                            },
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
                                onPressed: model.toggleConfirmPasswordSecure,
                                icon: Icon(Icons.remove_red_eye_rounded),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Trying to resetPassword'),
                              ),
                            );
                            model.onSubmit(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.green1,
                            onPrimary: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),
                        child: Text('Submit', style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white))),
                  ],
                ),
              ),
            ));
  }
}
