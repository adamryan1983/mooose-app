import 'package:flutter/material.dart';

import './home.dart';
import './subpages/important.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.label,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          label: "Home",
        ),
        TabNavigationItem(
          page: ImportantInfo(),
          icon: Icon(Icons.label_important_outline),
          label: "Information",
        ),
      ];
}
