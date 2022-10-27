import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/routes/app_navigator.dart';

import 'locator.dart';

class VuaciUserApp extends StatelessWidget {
  final String savedLocation;
  VuaciUserApp(this.savedLocation);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return AppNavigator(savedLocation);
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
