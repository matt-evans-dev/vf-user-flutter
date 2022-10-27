import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/ui/onboarding/splash_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/app_icon_widget.dart';

class SplashView extends StatelessWidget {
  static const String id = 'splash_view.xml';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.checkLogin(context),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: AppIconWidget(
            image: AppAssets.appLogo,
          ),
        ),
      ),
    );
  }
}
