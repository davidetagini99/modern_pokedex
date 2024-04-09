// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:custom_pokedex/components/AppBar.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "settings",
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [],
      ),
    );
  }
}