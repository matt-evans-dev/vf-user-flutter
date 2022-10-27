import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/emoji_types.dart';

class EmojiInfoWidget extends StatelessWidget {
  final EmojiTypes type;
  EmojiInfoWidget({@required this.type});

  @override
  Widget build(BuildContext context) {
    String asset;
    String statusText;
    switch (type) {
      case EmojiTypes.great:
        statusText = 'Great';
        asset = AppAssets.smileIcon;
        break;
      case EmojiTypes.good:
        statusText = 'Good';
        asset = AppAssets.neutralIcon;
        break;
      case EmojiTypes.bad:
        statusText = 'Bad';
        asset = AppAssets.sadIcon;
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXS),
      height: AppDimens.greyInfoHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            statusText,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            width: AppDimens.spacingXS,
          ),
          Image.asset(
            asset,
            height: AppDimens.greyEmojiAssetSize,
            width: AppDimens.greyEmojiAssetSize,
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppDimens.radiusXS),
      ),
    );
  }
}
