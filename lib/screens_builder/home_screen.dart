import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../services/get_dat_api.dart';
import '../widgets_builder/home_gridview.dart';
import '../data_model/data_model.dart';
import '../widgets_builder/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function isHideBottomNavBar;

  const HomeScreen({Key? key, required this.isHideBottomNavBar})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  late Future<List<Brand>?> products;
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = GetDataAPI.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: ScrollAppBar(
          elevation: 0,
          toolbarHeight: 230,
          flexibleSpace: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                'https://media.istockphoto.com/vectors/paper-art-of-smartphone-for-online-shopping-your-text-space-shopping-vector-id1224318136?k=20&m=1224318136&s=612x612&w=0&h=GHqnnldakfvn9JtiAZuPJxchwjXNJDRY3yX05tvx4xY=',
                fit: BoxFit.cover,
              ),
            ),
          ),
          controller: controller,
        ),
        body: FutureBuilder(
          future: products,
          builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('none');
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                     style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5,
                      right: 5,
                    ),
                    child: GridView.builder(
                      controller: controller,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        // childAspectRatio: 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      // itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return HomeGridView(snapshot: snapshot, index: index);
                      },
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
