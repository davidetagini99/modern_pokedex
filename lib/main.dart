// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:custom_pokedex/screens/home.dart';
import 'package:custom_pokedex/themes/ThemeDataStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = (prefs.getBool('isDarkModeEnabled') ?? false)
        ? ThemeMode.dark
        : ThemeMode.light;
    setState(() {});
  }

  void _updateTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeEnabled', themeMode == ThemeMode.dark);
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(updateTheme: _updateTheme),
      themeMode: _themeMode,
      theme: ThemeDataStyle.light,
      darkTheme: ThemeDataStyle.dark,
    );
  }
}
