
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/homepage.dart';
import 'package:shealth/UI/patientScreen.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/UI/splashscreen.dart';
import 'package:shealth/providers/auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isAuth = Provider.of<Auth>(context).isAuth;
    return isAuth
        ? PatientScreen()
        : FutureBuilder(
            future: Provider.of<Auth>(context).checkLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : HomePage(),
          );
  }
}