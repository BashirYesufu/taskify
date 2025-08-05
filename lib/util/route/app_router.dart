import 'package:flutter/cupertino.dart';

class AppRouter {

  static void goBack(BuildContext context){
    Navigator.pop(context);
  }

  static void launch(BuildContext context, {required String routeName, dynamic arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }


  static  Future<dynamic> clearAndNavigateTo(BuildContext context, String routeName, {arguments,String endRoute = "/"}) {
    if(Navigator.canPop(context)){
      return Navigator.pushNamedAndRemoveUntil(context, routeName,ModalRoute.withName(endRoute),arguments: arguments);
    }
    return Navigator.pushReplacementNamed(context, routeName,arguments: arguments);
  }

}