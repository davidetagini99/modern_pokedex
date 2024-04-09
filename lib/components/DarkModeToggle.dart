// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeToggle extends StatefulWidget {
  final Function(ThemeMode) updateTheme; // Add this line

  DarkModeToggle({required this.updateTheme}); // Add this line

  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  late bool isDarkModeEnabled = false; // Initialize with a default value

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
          _saveDarkModeState(value); // Save the switch state to SharedPreferences
          // Update the theme based on the toggle value
          ThemeMode themeMode = value ? ThemeMode.dark : ThemeMode.light;
          widget.updateTheme(themeMode);
        });
      },
    );
  }
}



