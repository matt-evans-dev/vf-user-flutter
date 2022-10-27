import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';

import 'account_viewmodel.dart';

class AccountView extends StatelessWidget {
  static const String id = 'account_view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
      viewModelBuilder: () => AccountViewModel(),
      builder: (context, model, child) => !model.isLoggedIn
          ? Scaffold(
              body: SafeArea(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Image.asset('assets/images/mix_logo.png'),
                    Padding(
                        padding: EdgeInsets.fromLTRB(34, 40, 34, 20),
                        child: Text('Find Your Favorite Food with Vuacifood!',
                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24.0), textAlign: TextAlign.center)),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () => model.goToSignUp(context),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.green1,
                            onPrimary: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.fromLTRB(13, 13, 13, 13)),
                        child: Text('Sign Up', style: Theme.of(context).textTheme.subtitle1.copyWith(color: AppColors.white))),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account? ", style: Theme.of(context).textTheme.subtitle2),
                        TextButton(
                          onPressed: () => model.goToLogin(context),
                          child: Text("Log in", style: Theme.of(context).textTheme.subtitle2.copyWith(color: AppColors.green1)),
                          style: TextButton.styleFrom(
                            primary: AppColors.green1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: AppBarWidget(),
              ),
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      model.userDetail.userName,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  model.userDetail.profilePic,
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0.0,
                                bottom: 0.0,
                                child: GestureDetector(
                                  child: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/icons/ic_camera.png"), fit: BoxFit.cover), // button text
                                      )),
                                  onTap: () {
                                    model.getImage(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 22.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).bottomAppBarColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowGrey,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My account',
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.0),
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_user.png',
                                        width: 18.0,
                                        height: 19.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'My account',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppColors.grey1,
                                    size: 22.0,
                                  ),
                                ],
                              ),
                              onTap: () {
                                model.goToAccountManage(context);
                              }),
                          SizedBox(height: 15.0),
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_payment.png',
                                        width: 18.0,
                                        height: 19.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Payment',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppColors.grey1,
                                    size: 22.0,
                                  ),
                                ],
                              ),
                              onTap: () {
                                model.goToPaymentManage(context);
                              }),
                          SizedBox(height: 20.0),
                          Text(
                            'Notifications',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 20.0),
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_bell.png',
                                        width: 18.0,
                                        height: 19.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Push notifications',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Switch(
                                          value: true,
                                          activeTrackColor: AppColors.cyan1,
                                          activeColor: AppColors.green1,
                                          onChanged: (value) {
                                            //Do you things
                                          })),
                                ],
                              ),
                              onTap: () {}),
                          SizedBox(height: 10.0),
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_email.png',
                                        width: 18.0,
                                        height: 19.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Email',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 30,
                                    child: Switch(
                                      value: true,
                                      activeTrackColor: AppColors.cyan1,
                                      activeColor: AppColors.green1,
                                      onChanged: (value) {
                                        //Do you things
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {}),
                          SizedBox(height: 20.0),
                          Text(
                            'More',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_sleep_mode.png',
                                    width: 18.0,
                                    height: 19.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Dark mode',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 60,
                                height: 30,
                                child: Switch(
                                  value: model.isDarkMode,
                                  activeTrackColor: AppColors.cyan1,
                                  activeColor: AppColors.green1,
                                  onChanged: model.changeTheme,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/ic_exit.png',
                                        width: 18.0,
                                        height: 19.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Log out',
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                model.onLogout(context);
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.0),
                  ],
                ),
              ),
            ),
    );
  }
}
