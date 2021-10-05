// @dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shealth/UI/pdfpage.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/doctors.dart';
import 'package:shealth/providers/patients.dart';
import 'package:shealth/providers/precription.dart';
import 'package:shealth/routers/AppRoutes.dart';
import 'package:shealth/routers/RouteNames.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Prescription()),
        ChangeNotifierProvider.value(value: Doctors()),
        ChangeNotifierProvider.value(value: Patients()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  headline1: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                  ))),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: RouteNames.landing),
    );
  }
}
