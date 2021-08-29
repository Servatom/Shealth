import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/doctors.dart';
import 'package:shealth/providers/patients.dart';
import 'package:shealth/routers/RouteNames.dart';

import 'custombutton.dart';

class PatientScreenForDoc extends StatefulWidget {
  @override
  _PatientScreenForDocState createState() =>
      _PatientScreenForDocState();
}

class _PatientScreenForDocState extends State<PatientScreenForDoc> {
  bool isInit = true;
  bool isLoading = false;
  String docId = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Patients>(context, listen: false)
          .getPatients(Provider.of<Auth>(context, listen: false).token)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patients>(context).patient;
    print(patient.length);
    return Scaffold(
      
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: patient.length,
                  itemBuilder: (ctx, index) {
                    print(patient[index].name);
                    return patient.length == 0
                        ? Container(
                            child: Center(
                            child: Text('No doctors added'),
                          ))
                        : Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal*20,vertical: SizeConfig.safeBlockVertical*10),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RouteNames.presForDoc,arguments: {"email":patient[index].email , "name":patient[index].name});
                            },
                            child: Container(
                              
                              height: SizeConfig.safeBlockVertical *120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff7f7c82).withOpacity(.24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical*20 , left: SizeConfig.safeBlockVertical*20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                              'Name: ',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            ),
                                            Text(
                                              '${patient[index].name}',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                              'Email: ',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            ),
                                            Text(
                                              '${patient[index].email}',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                              'Phone: ',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            ),
                                            Text(
                                              '${patient[index].phone}',
                                              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 20,
                color: Color(0xff49484b),
              ),
                                            )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.safeBlockHorizontal * 100,
                                      height: SizeConfig.safeBlockVertical * 80,
                                      child: Image.network('https://raw.githubusercontent.com/Servatom/Second-Hand/main/Front-End/images/default-avatar.png'),
                                    )
                                  ],
                                )
                              ),
                          ),
                        );
                  })),
    );
  }
}
