import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/ui/onboarding/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  static const String id = 'login_view';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
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
                          'Sign In',
                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  width: 120,
                                  child: DropdownButtonFormField(
                                    items: AppStrings.countryCodes.map((String countryCode) {
                                      return new DropdownMenuItem(
                                          value: countryCode,
                                          child: Row(
                                            children: <Widget>[
                                              // Icon(Icons.star),
                                              Text(countryCode),
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: model.onChangeCountryCode,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select country code';
                                      }
                                      return null;
                                    },
                                  )),
                              SizedBox(width: 13.0),
                              Expanded(
                                child: TextFormField(
                                    controller: TextEditingController(text: model.phoneNumber),
                                    onChanged: model.onChangePhoneNumber,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter phone number';
                                      }
                                      return null;
                                    },
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
                                    style: Theme.of(context).textTheme.subtitle2),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.0),
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
                                onPressed: model.onChangeSecureKeyboard,
                                icon: model.isSecure ? Icon(Icons.remove_red_eye_rounded) : Icon(Icons.visibility_off),
                              ),
                            ),
                            obscureText: model.isSecure,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () => model.goToForgot(context),
                      child: Text(
                        "Forgot password?",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1),
                      ),
                    ),
                    SizedBox(height: 45.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trying to login')));
                          model.onLogin(context);
                        }
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
                        'Sign In',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => _launchURL(AppStrings.termsURL),
                          child: Text("Terms and Conditions", style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green1)),
                        ),
                        Container(height: 20, child: VerticalDivider(color: AppColors.green1)),
                        TextButton(
                          onPressed: () => _launchURL(AppStrings.policyURL),
                          child: Text("Privacy Statement", style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green1)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New user? ", style: Theme.of(context).textTheme.subtitle2),
                        TextButton(
                          onPressed: () => model.goToSignUp(context),
                          child: Text("Sign up", style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}

void _launchURL(url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
