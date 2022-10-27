import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/cart_item_model.dart';
import 'package:vf_user_flutter_new/ui/widgets/cart/cart_card_viewmodel.dart';

import '../count_btn_widget.dart';

class CartCard extends StatelessWidget {
  final CartItemModel data;
  final int index;
  final int merchantIdx;
  CartCard({@required this.data, @required this.index, @required this.merchantIdx});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartCardViewModel>.reactive(
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(AppDimens.spacingXS),
              margin: EdgeInsets.only(right: AppDimens.spacingL),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimens.radiusM),
                ),
              ),
              child: ClipRRect(
                child: Image.network(
                  data.images[0],
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(70 / 2),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.productName,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => model.onRemove(index, merchantIdx),
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppDimens.spacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.productPrice} USD',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Theme.of(context).primaryColor, fontSize: AppDimens.fontM, fontWeight: FontWeight.w700),
                      ),
                      CountBtnWidget(
                        quantity: model.quantity,
                        onIncrease: () => model.onIncrease(index, merchantIdx),
                        onDecrease: () => model.onDecrease(index, merchantIdx),
                        bgColor: Theme.of(context).secondaryHeaderColor,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => CartCardViewModel(data, index, merchantIdx),
    );
  }
}
