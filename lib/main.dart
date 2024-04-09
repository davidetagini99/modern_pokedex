// ignore_for_file: prefer_const_constructors

import 'package:custom_pokedex/themes/ThemeDataStyle.dart';
import 'package:flutter/material.dart';
import 'package:custom_pokedex/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeDataStyle.light,
      darkTheme: ThemeDataStyle.dark,
    );
  }
}