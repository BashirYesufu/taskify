import 'package:flutter/material.dart';
import '../../ui/features/dashboard/dashboard.dart';

class RouteHandler {
  static String initialRoute = Dashboard.routeName;

  static Map<String, WidgetBuilder> routes = {
    Dashboard.routeName: (context) => Dashboard(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings route) {


    switch (route.name) {
      default: return MaterialPageRoute(builder: (context)=> Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('Uninitialised route'),
        ),
      ));
    }

  }


}