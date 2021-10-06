import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets_builder/drawer_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const String routName ='/orders';
  final Function? isHideBottomNavBar;
  
  const OrdersScreen({Key? key, this.isHideBottomNavBar})
      : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar!(true);
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar!(false);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: ListView.builder(
          itemCount: 70,
          itemBuilder: (_, index) {
            return const Text("love");
          },
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
