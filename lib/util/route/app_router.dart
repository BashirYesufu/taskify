import 'package:flutter/cupertino.dart';

class AppRouter {

  static void goBack(BuildContext context){
    Navigator.pop(context);
  }

  static void launch(BuildContext context, {required String routeName, dynamic arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }


  //
  // static void clearAndLaunch(BuildContext context, {required String routeName, dynamic arguments}) {
  //   Navigator.pushNamedAndRemoveUntil(context, routeName, arguments: arguments);
  // }

}