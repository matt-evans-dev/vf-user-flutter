import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/emoji_types.dart';
import 'package:vf_user_flutter_new/constants/enum/grey_btn_types.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';

import '../emoji_info_widget.dart';
import '../grey_info_widget.dart';

class ExploreCardWidget extends StatelessWidget {
  final MerchantModel data;
  final Function onPress;
  ExploreCardWidget({
    @required this.data,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        width: AppDimens.exploreCardWidth,
        height: AppDimens.exploreCardHeight,
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
        decoration: BoxDecoration(
          image: DecorationImage(
            // image: AssetImage(AppAssets.foodImg),
            image: NetworkImage(data.profilePic),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusN),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: AppDimens.spacing,
                right: AppDimens.spacing,
              ),
              alignment: Alignment.topRight,
              child: Icon(
                Icons.favorite_outline_sharp,
                color: Color(0xFFFBA83C),
                size: AppDimens.favouriteIconSize,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: AppDimens.exploreCardHeight / 2.5,
                padding: EdgeInsets.only(left: AppDimens.spacing, right: AppDimens.spacing, top: AppDimens.spacing, bottom: AppDimens.spacingM),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppDimens.radiusN),
                    bottomRight: Radius.circular(AppDimens.radiusN),
                  ),
                  color: AppColors.cardOverlayColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(height: AppDimens.spacing),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GreyInfoWidget(
                              type: GreyButtonType.time,
                              data: '30',
                            ),
                            SizedBox(width: AppDimens.spacing),
                            GreyInfoWidget(
                              type: GreyButtonType.price,
                              data: '18',
                            )
                          ],
                        ),
                        EmojiInfoWidget(type: EmojiTypes.great),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
