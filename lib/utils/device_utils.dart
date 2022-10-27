import 'package:flutter/material.dart';

class DeviceUtils {
  // Hides the keyboard if its already open
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // accepts a double [scale] and returns scaled sized based on the screen orientation
  static double getScaledSize(BuildContext context, double scale) =>
      scale * (MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height);

  // accepts a double [scale] and returns scaled sized based on the screen
  static double getScaledWidth(BuildContext context, double scale) => scale * MediaQuery.of(context).size.width;

  // accepts a double [scale] and returns scaled sized based on the screen height
  static double getScaledHeight(BuildContext context, double scale) => scale * MediaQuery.of(context).size.height;

  static double spacing(double multiplier) => 8 * multiplier;
}
