// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields

import 'package:custom_pokedex/classes/UppercaseChars.dart';
import 'package:flutter/material.dart';
import 'package:custom_pokedex/classes/DrawerItem.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> drawerItems;

  CustomDrawer({Key? key, required this.drawerItems}) : super(key: key);

  late UppercaseChars _uppercaseChars = UppercaseChars();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.zero,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _uppercaseChars.capitalize("modern pokedex"),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                return ListTile(
                  leading: Icon(item.leadingIcon),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: item.onTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
