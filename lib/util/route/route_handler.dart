import 'package:flutter/material.dart';
import 'package:taskify/ui/features/auth/registration_screen.dart';
import '../../ui/features/auth/login_screen.dart';
import '../../ui/features/dashboard/dashboard.dart';

class RouteHandler {
  static String initialRoute = RegisterScreen.routeName;

  static Map<String, WidgetBuilder> routes = {
    Dashboard.routeName: (context) => Dashboard(),
    RegisterScreen.routeName: (context) => RegisterScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
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