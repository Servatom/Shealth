import 'package:flutter/material.dart';
import 'package:shealth/UI/homepage.dart';
import 'package:shealth/UI/tobeornottobe.dart';

import 'RouteNames.dart';
class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homepage:
        return MaterialPageRoute<dynamic>(builder: (_) => HomePage());
      case RouteNames.tobe:
      var type = settings.arguments as String;
      return MaterialPageRoute<dynamic>(builder: (_) => TobeOrNotToBe(type: type,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}