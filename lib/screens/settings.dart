// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:custom_pokedex/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:custom_pokedex/components/DarkModeToggle.dart';

class Settings extends StatelessWidget {
  final Function(ThemeMode) updateTheme; // Add this line

  Settings({required this.updateTheme}); // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "settings",
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              "dark mode"
            ),
            trailing: DarkModeToggle(updateTheme: updateTheme),
          ),
        ],
      ),
    );
  }
}

// child: DarkModeToggle(updateTheme: updateTheme), // Pass the updateTheme function here