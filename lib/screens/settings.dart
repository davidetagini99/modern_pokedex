// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:custom_pokedex/components/AppBar.dart';
import 'package:custom_pokedex/main.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: "settings",
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text("Dark Mode"),
            trailing: Switch(
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                  // Pass the updated value to MyApp
                  MyApp.of(context)?.updateDarkMode(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
