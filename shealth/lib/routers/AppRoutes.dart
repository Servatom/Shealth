import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shealth/UI/homepage.dart';
import 'package:shealth/UI/landingpage.dart';
import 'package:shealth/UI/loginScreen.dart';
import 'package:shealth/UI/pdfpage.dart';
import 'package:shealth/UI/prescriptionforDoc.dart';
import 'package:shealth/UI/registerDoctor.dart';
import 'package:shealth/UI/registerPatient.dart';
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
      case RouteNames.registerDoctor:
      return MaterialPageRoute<dynamic>(builder: (_) => RegisterDoctor());
      case RouteNames.login:
      var type = settings.arguments as String;
      return MaterialPageRoute<dynamic>(builder: (_) => LoginScreen(type: type,));
      case RouteNames.ladning:
      var type = settings.arguments as String;
      return MaterialPageRoute<dynamic>(builder: (_) => LandingPage());
      case RouteNames.registerPatient:
      return MaterialPageRoute<dynamic>(builder: (_) => RegisterPatient());
      case RouteNames.pdfView:
      var url = settings.arguments as String;
      return MaterialPageRoute<dynamic>(builder: (_) => PdfView(url: url,));
      case RouteNames.presForDoc:
      var data = settings.arguments as Map<String,dynamic>;
      
      return MaterialPageRoute<dynamic>(builder: (_) => PrescriptionScreenForDoc(email: data["email"],name: data["name"],));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}