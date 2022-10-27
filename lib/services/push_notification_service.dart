import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vf_user_flutter_new/locator.dart';
import 'package:vf_user_flutter_new/services/shared_preference/shared_preference_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final SharedPreferenceService _sharedPrefService = locator<SharedPreferenceService>();

  Future initialise() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } else {
      String fcmToken = await _fcm.getToken();
      print("Push Messaging token: $fcmToken");
      await _sharedPrefService.saveFCMToken(fcmToken);
    }
  }
}
