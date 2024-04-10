// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const DrawerItem({
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });
}
