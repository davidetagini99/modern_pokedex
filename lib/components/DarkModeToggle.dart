// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // I've used this package to save the settings, so the states of the objects around the app

class DarkModeToggle extends StatefulWidget {
  final Function(ThemeMode) updateTheme;

  DarkModeToggle({required this.updateTheme});

  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  late bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentTheme();
  }

  void _loadCurrentTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkModeEnabled') ?? false;
    setState(() {
      isDarkModeEnabled = isDarkMode;
    });
  }

  void _saveDarkModeState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isDarkModeEnabled,
      onChanged: (value) {
        setState(() {
          isDarkModeEnabled = value;
          _saveDarkModeState(value);
          ThemeMode themeMode = value ? ThemeMode.dark : ThemeMode.light;
          widget.updateTheme(themeMode);
        });
      },
    );
  }
}



