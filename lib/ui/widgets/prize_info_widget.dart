import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/prize_types.dart';

class PrizeInfoWidget extends StatelessWidget {
  final PrizeType type;
  PrizeInfoWidget({@required this.type});

  @override
  Widget build(BuildContext context) {
    String asset;

    switch (type) {
      case PrizeType.gold:
        asset = AppAssets.goldMedalIcon;
        break;
      case PrizeType.silver:
        asset = AppAssets.silverMedalIcon;
        break;
      case PrizeType.bronze:
        asset = AppAssets.bronzeMedalIcon;
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXS),
      height: AppDimens.greyInfoHeight,
      child: Image.asset(
        asset,
        height: AppDimens.greyPrizeAssetSize,
        width: AppDimens.greyPrizeAssetSize,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppDimens.radiusXS),
      ),
    );
  }
}
