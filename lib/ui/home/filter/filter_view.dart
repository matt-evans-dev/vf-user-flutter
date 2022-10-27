import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/constants/enum/filter_option.dart';
import 'package:vf_user_flutter_new/constants/strings.dart';
import 'package:vf_user_flutter_new/constants/vals.dart';
import 'package:vf_user_flutter_new/ui/home/filter/filter_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/round_btn_widget.dart';

import '../../../locator.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
        ),
        body: Container(
          padding: EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title('Kitchen'),
              _StringFilters(FilterOptions.KITCHEN),
              _Title('Food'),
              _StringFilters(FilterOptions.FOOD),
              _Title('Dietary'),
              _StringFilters(FilterOptions.DIETARY),
              _Title('Rating'),
              _RatingFilters(),
              FlutterSlider(
                values: [model.lowerValue, model.upperValue],
                rangeSlider: true,
                max: 500,
                min: 0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  model.updateRangeValue(lowerValue, upperValue);
                },
              ),
              RoundBtnWidget(
                onPress: model.onApply,
                title: 'Apply',
              ),
              SizedBox(
                height: AppDimens.spacing,
              ),
              model.hasFilterOptions()
                  ? RoundBtnWidget(
                      onPress: model.onClean,
                      title: 'Clean Filter',
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<FilterViewModel>(),
      disposeViewModel: false,
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  _Title(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class _StringFilters extends StatelessWidget {
  final FilterOptions flOption;
  _StringFilters(this.flOption);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) {
        List<String> filtersData = [];
        int selVal;
        switch (flOption) {
          case FilterOptions.KITCHEN:
            filtersData = AppStrings.flCountries;
            selVal = model.kitchenIndex;
            break;
          case FilterOptions.FOOD:
            filtersData = AppStrings.flFoods;
            selVal = model.foodIndex;
            break;
          case FilterOptions.DIETARY:
            filtersData = AppStrings.flDietaries;
            selVal = model.dietaryIndex;
            break;
          default:
            filtersData = [];
        }

        return Wrap(
          spacing: AppDimens.spacing,
          children: filtersData
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  ChoiceChip(
                    label: Text(value),
                    selected: selVal == index,
                    selectedColor: Theme.of(context).primaryColor,
                    onSelected: (bool value) {
                      model.updateIndex(flOption, value, index);
                    },
                    backgroundColor: Colors.white,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: selVal == index ? Colors.white : Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                    elevation: 2,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppDimens.spacingS),
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        );
      },
      viewModelBuilder: () => locator<FilterViewModel>(),
      disposeViewModel: false,
    );
  }
}

class _RatingFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterViewModel>.reactive(
      builder: (context, model, child) => Wrap(
        spacing: AppDimens.spacing,
        children: AppValues.ratingIcons
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                GestureDetector(
                  onTap: () => model.updateRating(index),
                  child: Container(
                    margin: EdgeInsets.only(top: AppDimens.spacing),
                    width: AppDimens.flIconBtn,
                    height: AppDimens.flIconBtn,
                    child: Image.asset(value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.flIconBtn / 2),
                      color: model.rating == index ? AppColors.grey1 : Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
      viewModelBuilder: () => locator<FilterViewModel>(),
      disposeViewModel: false,
    );
  }
}
