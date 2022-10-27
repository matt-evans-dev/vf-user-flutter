import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/ui/home/home/home_viewmodel.dart';

import '../../../locator.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(bottom: AppDimens.spacingL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // DropdownButton<String>(
            //   items: AppStrings.searchFilterOptions.map((String value) {
            //     return DropdownMenuItem(
            //       value: value,
            //       child: Text(value),
            //       // style: Theme.of(context).textTheme.bodyText2,
            //     );
            //   }).toList(),
            //   onChanged: model.selSearchFilterOption,
            //   value: model.searchFilter,
            // ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'Search by restaurant',
                  hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusM),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppDimens.fontM),
                onSubmitted: model.onShowFilterDialog,
              ),
            ),
            GestureDetector(
              onTap: model.showFilterView,
              child: Container(
                width: AppDimens.flBtnWidth,
                height: AppDimens.flBtnHeight,
                child: Icon(
                  Icons.filter_list_outlined,
                  color: Theme.of(context).accentColor,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                    AppDimens.radiusM,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      disposeViewModel: false,
    );
  }
}
