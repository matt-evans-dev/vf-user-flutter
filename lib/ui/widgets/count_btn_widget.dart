import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';

class CountBtnWidget extends StatelessWidget {
  final Color bgColor;
  final double qtyFontSize;
  final Color color;
  final int quantity;
  final Function onIncrease;
  final Function onDecrease;
  CountBtnWidget({
    this.bgColor = Colors.white,
    this.qtyFontSize = AppDimens.fontN,
    this.color = AppColors.black1,
    @required this.quantity,
    @required this.onIncrease,
    @required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IncrementBtn(
          onPress: this.onDecrease,
          title: '-',
          bgColor: this.bgColor,
          color: color,
        ),
        SizedBox(width: AppDimens.spacing),
        Text(
          this.quantity.toString(),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: this.qtyFontSize,
              ),
        ),
        SizedBox(width: AppDimens.spacing),
        _IncrementBtn(
          onPress: this.onIncrease,
          title: '+',
          bgColor: this.bgColor,
          color: color,
        ),
      ],
    );
  }
}

class _IncrementBtn extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color color;
  final Function onPress;
  _IncrementBtn({this.title, this.bgColor, this.color, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: this.color,
                fontSize: AppDimens.fontL,
                fontWeight: FontWeight.w600,
              ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.radiusXS)),
          color: bgColor,
        ),
      ),
    );
  }
}
