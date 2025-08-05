import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardBarItem {
  String title;
  Widget screen;
  IconData icon;

  DashboardBarItem({
    required this.title,
    required this.screen,
    required this.icon,
});
  
  static List<DashboardBarItem> items = [
    DashboardBarItem(title: 'Home', screen: Container(), icon: Icons.home),
    DashboardBarItem(title: 'Tasks', screen: Container(), icon: Icons.task),
    DashboardBarItem(title: 'Account', screen: Container(), icon: Icons.person),
  ];

}