import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../screens_builder/details_screen.dart';
import 'package:flutter/material.dart';

class HomeGridView extends StatelessWidget {
  final snapshot;
  final int index;

  const HomeGridView({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCard(context);
  }

  buildCard(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      style:  NeumorphicStyle(
        lightSource: LightSource.bottomRight,
        // boxShape: NeumorphicBoxShape.rect(),
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shadowLightColor: Colors.lightBlueAccent,
        shadowDarkColor: Colors.blue,
        shadowLightColorEmboss: Colors.black,
        shadowDarkColorEmboss: Colors.white,
        border:const NeumorphicBorder(
          color: Colors.black, //0x33000000
          width: .2,
        ),
        depth: -9,
      ),
      child: Card(
        child: InkWell(
          onTap: () => goToDetailsScreen(context, snapshot, index),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0, left: 8.0, right: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    snapshot.data![index].imageLink,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        snapshot.data![index].name,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Text(snapshot.data![index].price + '\$',
                        style: Theme.of(context).textTheme.caption)
                  ],
                ),
              ],
            ),
          ),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

goToDetailsScreen(context, snapshot, index) {
  Navigator.of(context).pushNamed(
    DetailsScreen.routName,
    arguments: {
      'name': snapshot.data![index].name,
      'img': snapshot.data![index].imageLink,
      'price': snapshot.data![index].price,
      'description': snapshot.data![index].description,
      'brand': snapshot.data![index].brand,
      'id': snapshot.data![index].id,
      'updatedAt': snapshot.data![index].updatedAt,
    },
  );
}
