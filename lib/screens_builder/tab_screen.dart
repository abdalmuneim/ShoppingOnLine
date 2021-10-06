import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shoponline/screens_builder/offers_screen.dart';
import 'package:shoponline/screens_builder/orders_screen.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routName = '/';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late AnimationController animationController;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _pages = <Widget>[
      OrdersScreen(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      HomeScreen(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      OffersScreen(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
    ];
  }

  @override
  void dispose() {
    // ...
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: animationController,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.lightBlueAccent,
          currentIndex: _selectedIndex,
          selectedFontSize: 13,
          unselectedFontSize: 10,
          selectedIconTheme:
              const IconThemeData(color: Colors.amberAccent, size: 30),
          elevation: 0,
          onTap: _onItemTapped,
          items: [
            buildBottomNavigationBarItem('MyOrders', Icons.shopping_cart),
            buildBottomNavigationBarItem('Products', Icons.category),
            buildBottomNavigationBarItem('Offers', Icons.local_offer),
          ],
        ),
      ),
    );
  }

  buildBottomNavigationBarItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      label: title,
      icon: Icon(
        icon,
      ),
    );
  }
}
