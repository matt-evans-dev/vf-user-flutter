import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/grey_btn_types.dart';

class GreyInfoWidget extends StatelessWidget {
  final GreyButtonType type;
  final String data;
  GreyInfoWidget({@required this.type, @required this.data});

  @override
  Widget build(BuildContext context) {
    String content;
    switch (type) {
      case GreyButtonType.time:
        content = data + 'min';
        break;
      case GreyButtonType.price:
        content = 'from \$' + data;
        break;
      default:
        content = data;
        break;
    }

    return Container(
      height: AppDimens.greyInfoHeight,
      padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXS),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppDimens.radiusXS),
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
