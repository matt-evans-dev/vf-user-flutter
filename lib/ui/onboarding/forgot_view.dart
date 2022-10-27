import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/ui/onboarding/forgot_viewmodel.dart';

import '../../locator.dart';

class ForgotView extends StatelessWidget {
  static const String id = 'forgot_view';

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
                    Text(
                      'We can help by sending you OTP code',
                      style: Theme.of(context).textTheme.subtitle1,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Trying to get OTP code'),
                            ),
                          );
                          model.onGetOTP(context);
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
                        'Get OTP',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
