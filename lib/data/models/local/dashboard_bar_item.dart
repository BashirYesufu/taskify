import 'package:flutter/material.dart';
import '../../../ui/features/dashboard/home_screen.dart';
import '../../../ui/features/more/more_screen.dart';
import '../../../ui/features/project/project_screen.dart';

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
    DashboardBarItem(title: 'Home', screen: HomeScreen(), icon: Icons.home),
    DashboardBarItem(title: 'Projects', screen: ProjectScreen(), icon: Icons.task),
    DashboardBarItem(title: 'More', screen: MoreScreen(), icon: Icons.more_horiz_rounded),
  ];

}