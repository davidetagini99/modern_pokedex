// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions; // List of widgets for actions
  final Color backgroundColor;
  final double elevation;
  final Color shadowColor;

  const CustomAppBar({Key? key, required this.title, required this.actions, required this.backgroundColor, required this.elevation, required this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions, // Set the actions here
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
