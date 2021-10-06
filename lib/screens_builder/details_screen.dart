import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shoponline/screens_builder/orders_screen.dart';

class DetailsScreen extends StatefulWidget {
  static final String routName = '/detailsScreen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var routArg =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;
    final name = routArg['name'];
    final img = routArg['img'];
    final price = routArg['price'];
    final description = routArg['description'];
    final brand = routArg['brand'];
    final id = routArg['id'];
    final updatedAt = routArg['updatedAt'];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OrdersScreen.routName);
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 33,
                  color: Colors.white,
                )),
          )
        ],
        title: Text(
          '$brand',
          // style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 0,
                      child: SizedBox(
                        width: 400,
                        height: 200,
                        child: ClipRRect(
                          child: Image.network(
                            img,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // height: MediaQuery.of(context).size.height / 1.92,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    buildRichText('Brand', brand),
                                    Expanded(child: buildRichText('Id', id)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                buildRichText('Name', name),
                                const SizedBox(height: 5),
                                buildRichText('Description', description),
                                // SizedBox(height: 5),
                                buildRichText('UpdatedAt', updatedAt),
                                // buildRichText(brand),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 190,
              right: 30,
              child: Text(
                  price + '\$',
                  style: Theme
                      .of(context)
                      .textTheme
                      .caption
              ))
        ],
      ),
      floatingActionButton: SpeedDial(
        // childMargin: const EdgeInsets.only(top:25),
        overlayOpacity: .5,
        spaceBetweenChildren: 20,
        overlayColor: Colors.black,
        animatedIcon: AnimatedIcons.menu_close,
        // label: const Text('close'),
        children: [
        SpeedDialChild(child: const Icon(Icons.apps,color: Colors.red,),),
        SpeedDialChild(child: const  Icon(Icons.apps,color: Colors.red,),),
        SpeedDialChild(child: const Icon(Icons.apps,color: Colors.red,),),
      ],
    ));
  }

  final _fav = [];

  isFav(id) {
    return _fav.any((element) => element.id == id);
  }

  buildRichText(type, data) {
    return Card(
      color: Colors.lightGreenAccent[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            style: Theme
                .of(context)
                .textTheme
                .subtitle1,
            children: [
              TextSpan(
                  text: '$type: ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .caption
              ),
              TextSpan(
                text: data.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
