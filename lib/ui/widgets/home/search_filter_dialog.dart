import 'package:flutter/material.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/enum/search_filter.dart';

class SearchFilterDialog extends StatefulWidget {
  final Function onSearch;
  SearchFilterDialog({@required this.onSearch});

  @override
  _SearchFilterDialogState createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  SearchFilter _searchFilter = SearchFilter.Foods;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      buttonPadding: EdgeInsets.all(0.0),
      title: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Text(
          'What do you want to search?',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Foods'),
              leading: Radio<SearchFilter>(
                value: SearchFilter.Foods,
                groupValue: _searchFilter,
                onChanged: (SearchFilter value) {
                  setState(() {
                    _searchFilter = value;
                  });
                },
                activeColor: AppColors.green1,
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Restaurants'),
              leading: Radio<SearchFilter>(
                value: SearchFilter.Restaurants,
                groupValue: _searchFilter,
                onChanged: (SearchFilter value) {
                  setState(() {
                    _searchFilter = value;
                  });
                },
                activeColor: AppColors.green1,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            widget.onSearch(_searchFilter);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
