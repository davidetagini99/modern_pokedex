// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:custom_pokedex/classes/DrawerItem.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> drawerItems;

  const CustomDrawer({Key? key, required this.drawerItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: <Widget>[
          Container( // Wrap DrawerHeader with Container
          width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "modern pokedex",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                return ListTile(
                  leading: Icon(item.leadingIcon), // Show leading icon
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
