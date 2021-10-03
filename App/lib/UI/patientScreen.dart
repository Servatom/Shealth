import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/doctorsscreenpatient.dart';
import 'package:shealth/UI/prescriptionscreen.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/precription.dart';
import 'package:shealth/routers/RouteNames.dart';

class PatientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF3F1F5),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                }),
            IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.qrCode);
                })
          ],
          automaticallyImplyLeading: false,
          title: Text(
            'Shealth',
            style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: SizeConfig.safeBlockVertical * 24, color: Color(0xffF3F1F5)),
          ),
          backgroundColor: Color(0xffb793da),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xff49484b),
            labelStyle: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.safeBlockVertical * 16, color: Color(0xffb793da)),
            tabs: [
              Tab(
                text: 'Prescriptions',
              ),
              Tab(
                text: 'Doctors',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          PrescriptionScreen(),
          DoctorsScreenForPatient(),
        ]),
      ),
    );
  }
}
