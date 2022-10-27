import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';

import 'app.dart';
import 'locator.dart';

Future<void> main() async {
  // Register all services.
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  // Set orientation as portrait.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Get saved location address.
  var sharedPref = await SharedPreferences.getInstance();
  String savedLocation = sharedPref.getString(AppStrings.location);

  // Firebase initialize.
  Firebase.initializeApp();

  runApp(VuaciUserApp(savedLocation));
}
