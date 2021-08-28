import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';

class PatientScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF3F1F5),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            await Provider.of<Auth>(context,listen: false).getPdfAndUpload();
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffb793da),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Shealth',
            style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: SizeConfig.safeBlockVertical * 24,
              color: Color(0xffF3F1F5)
            ),
            ),
          backgroundColor: Color(0xffb793da),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xff49484b),
            labelStyle: Theme.of(context).textTheme.headline2?.copyWith(
              fontSize: SizeConfig.safeBlockVertical * 16,
              color: Color(0xffb793da)
            ),
            tabs: [
              Tab(text: 'Prescriptions',),
              Tab(text: 'Reports',),
              Tab(text: 'Doctors',)
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(child: Center(child: Text('Prescriptions')),),
          Container(child: Center(child: Text('Reports')),),
          Container(child: Center(child: Text('Doctors')),),
        ]),
      ),
    );
  }
}