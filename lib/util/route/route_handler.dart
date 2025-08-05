import 'package:flutter/material.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/features/auth/registration_screen.dart';
import '../../ui/features/ai/ai_scheduler_screen.dart';
import '../../ui/features/auth/login_screen.dart';
import '../../ui/features/dashboard/dashboard.dart';
import '../../ui/features/project/create_project_screen.dart';
import '../../ui/features/project/project_details_screen.dart';

class RouteHandler {
  static String initialRoute = LoginScreen.routeName;

  static Map<String, WidgetBuilder> routes = {
    Dashboard.routeName: (context) => Dashboard(),
    RegisterScreen.routeName: (context) => RegisterScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    CreateProjectScreen.routeName: (context) => CreateProjectScreen(),
    AISchedulerScreen.routeName: (context) => AISchedulerScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings route) {

    switch (route.name) {

      case ProjectDetailsScreen.routeName:
        final args = route.arguments as Project;
        return MaterialPageRoute(builder: (context) {
          return  ProjectDetailsScreen(project: args,);
        });

      default: return MaterialPageRoute(builder: (context)=> Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('Uninitialised route'),
        ),
      ));
    }

  }


}