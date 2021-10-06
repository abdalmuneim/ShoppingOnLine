import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets_builder/drawer_widget.dart';

class OffersScreen extends StatefulWidget {
  final Function isHideBottomNavBar;

  const OffersScreen({Key? key, required this.isHideBottomNavBar})
      : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
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
          title: const Text('Offers'),
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
