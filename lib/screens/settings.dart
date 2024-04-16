// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, must_be_immutable

import 'package:custom_pokedex/classes/UppercaseChars.dart';
import 'package:custom_pokedex/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:custom_pokedex/components/DarkModeToggle.dart';

class Settings extends StatelessWidget {
  final Function(ThemeMode) updateTheme;

  Settings({required this.updateTheme});

  UppercaseChars _uppercaseChars = UppercaseChars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [],
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _uppercaseChars.capitalize("dark mode"),
              ),
              SizedBox(
                width: 10,
              ),
              DarkModeToggle(updateTheme: updateTheme,),
            ],
          ),
        ],
      ),
    );
  }
}