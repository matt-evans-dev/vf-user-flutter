import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vf_user_flutter_new/constants/assets.dart';
import 'package:vf_user_flutter_new/constants/colors.dart';
import 'package:vf_user_flutter_new/constants/dimens.dart';
import 'package:vf_user_flutter_new/models/order/order.dart';
import 'package:vf_user_flutter_new/ui/orders/orders_viewmodel.dart';
import 'package:vf_user_flutter_new/widgets/app_bar_widget.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:intl/intl.dart';

class OrdersView extends StatelessWidget {
  static const String id = 'orders_view';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderViewModel>.reactive(
      viewModelBuilder: () => OrderViewModel(),
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: AppBarWidget(),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: model.orders.length > 0
                ? ContainedTabBarView(
                    tabs: [Text('Oncoming'), Text('Previous')],
                    views: [
                      _oncomingTab(context, model.orders),
                      _previousTab(context, model.orders),
                    ],
                    onChange: (index) => print(index),
                    tabBarProperties: TabBarProperties(
                      indicatorColor: AppColors.green1,
                      labelColor: AppColors.green1,
                      unselectedLabelColor: Theme.of(context).accentColor,
                    ),
                  )
                : NoOrderWidget(),
          )),
    );
  }
}

Widget _oncomingTab(BuildContext context, List<Order> orders) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    children: orders.where((element) => element.orderStatus == 'initiated').map((order) => orderCard(context, order)).toList(),
  );
}

Widget _previousTab(BuildContext context, List<Order> orders) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    children: orders.where((element) => element.orderStatus != 'initiated').map((order) => orderCard(context, order)).toList(),
  );
}

Widget orderCard(BuildContext context, Order order) {
  return Column(
    children: [
      SizedBox(height: 22.0),
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey,
              blurRadius: 10,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                order.merchant.profilePic,
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.merchant.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Image.asset(
                      order.userRating == 5
                          ? 'assets/icons/ic_gold_medal.png'
                          : order.userRating != null && order.userRating > 3
                              ? 'assets/icons/ic_silver_medal.png'
                              : 'assets/icons/ic_bronze_medal.png',
                      width: 15.0,
                      height: 20.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.totalItem.toString() + ' items',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      // 'Feb, 23 2021',
                      DateFormat.yMMMd().format(order.updatedTime),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(width: 12.0),
          ]),
        ),
      ),
    ],
  );
}

class NoOrderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.bagImg),
          SizedBox(
            height: AppDimens.spacing,
          ),
          Text(
            'You do not have any orders yet.\nGo ahead and choose something from the menu!',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
