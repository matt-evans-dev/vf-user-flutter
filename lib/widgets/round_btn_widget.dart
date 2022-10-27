import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';

class RoundBtnWidget extends StatelessWidget {
  final Function onPress;
  final String title;
  final double width;
  final double height;
  final Color bgColor;
  final Color txtColor;
  final Color borderColor;

  RoundBtnWidget({
    @required this.onPress,
    this.title,
    this.width = double.infinity,
    this.height = 50,
    this.bgColor = AppColors.green1,
    this.txtColor = Colors.white,
    this.borderColor = AppColors.green1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: TextButton(
        onPressed: this.onPress,
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.button.copyWith(
                color: txtColor,
              ),
        ),
      ),
    );
  }
}
