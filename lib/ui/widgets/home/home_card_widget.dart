import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/grey_btn_types.dart';
import 'package:vf_user_flutter_new/constants/enum/prize_types.dart';
import 'package:vf_user_flutter_new/models/home/product_model.dart';

import '../grey_info_widget.dart';
import '../prize_info_widget.dart';

class HomeCardWidget extends StatelessWidget {
  final ProductModel data;
  final Function showFoodCollectionView;
  HomeCardWidget({@required this.data, @required this.showFoodCollectionView});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showFoodCollectionView(data),
      child: Container(
        width: AppDimens.homeCardWidth,
        height: AppDimens.homeCardHeight,
        margin: EdgeInsets.all(AppDimens.spacing),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data.image[0]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusN),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(left: AppDimens.spacing, right: AppDimens.spacing, top: AppDimens.spacingL, bottom: AppDimens.spacingM),
            width: AppDimens.homeCardWidth,
            height: AppDimens.homeCardHeight / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    PrizeInfoWidget(
                      type: PrizeType.gold,
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimens.radiusN),
                bottomRight: Radius.circular(AppDimens.radiusN),
              ),
              color: AppColors.cardOverlayColor,
            ),
          ),
        ),
      ),
    );
  }
}
