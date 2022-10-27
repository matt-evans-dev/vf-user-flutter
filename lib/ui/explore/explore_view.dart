import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/home/merchant_model.dart';
import 'package:vf_user_flutter_new/ui/explore/explore_viewmodel.dart';
import 'package:vf_user_flutter_new/ui/widgets/explore/explore_card_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/explore/explore_search_bar_widget.dart';
import 'package:vf_user_flutter_new/ui/widgets/home/address_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:vf_user_flutter_new/widgets/progress_indicator_widget.dart';

import '../../locator.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: Container(
          padding: EdgeInsets.only(left: AppDimens.screenPadding, right: AppDimens.screenPadding, top: AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressBarWidget(
                showLocationPickerView: model.showLocationPickerView,
              ),
              ExploreSearchBarWidget(),
              _buildInfo(context, model.merchants.length, model.isLoading),
              Expanded(
                child: model.isLoading
                    ? ProgressIndicatorWidget()
                    : ListView.builder(
                        itemCount: model.merchants.length,
                        itemBuilder: (context, i) => ExploreCardWidget(
                          data: model.merchants[i],
                          onPress: () => model.showFoodCollectionView(model.merchants[i]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<ExploreViewModel>(),
      disposeViewModel: false,
    );
  }

  Widget _buildInfo(BuildContext context, int count, isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Near By',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          !isLoading ? '$count Restaurants found near' : '',
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: AppDimens.spacing,
        ),
      ],
    );
  }
}
