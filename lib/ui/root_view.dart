import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vf_user_flutter_new/routes/bottom_navigator.dart';

class RootView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigator(),
    );
  }
}
