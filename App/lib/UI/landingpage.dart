import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shealth/UI/doctorscreen.dart';
import 'package:shealth/UI/homepage.dart';
import 'package:shealth/UI/patientScreen.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/UI/splashscreen.dart';
import 'package:shealth/providers/auth.dart';

class LandingPage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final type = Provider.of<Auth>(context).user.isDoctor;
    SizeConfig().init(context);
    bool isAuth = Provider.of<Auth>(context).isAuth;
    return isAuth
        ? type
            ? DoctorScreen()
            : PatientScreen()
        : FutureBuilder(
            future: Provider.of<Auth>(context).checkLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : HomePage(),
          );
  }
}
