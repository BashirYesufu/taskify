import 'package:flutter/material.dart';
import 'package:taskify/util/route/route_handler.dart';

class App extends StatefulWidget {
  const App({super.key});
  static final App sharedInstance = App();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RouteHandler.routes,
      initialRoute: RouteHandler.initialRoute,
      onGenerateRoute: RouteHandler.onGenerateRoute,
    );
  }
}
