import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/providers/doctors.dart';

import 'custombutton.dart';

class DoctorsScreenForPatient extends StatefulWidget {
  @override
  _DoctorsScreenForPatientState createState() =>
      _DoctorsScreenForPatientState();
}

class _DoctorsScreenForPatientState extends State<DoctorsScreenForPatient> {
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
      Provider.of<Doctors>(context, listen: false)
          .getDoctors(Provider.of<Auth>(context, listen: false).token)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctors = Provider.of<Doctors>(context).doctor;
    print(doctors.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29)),
                  child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Doc Id',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(
                        color: Color(0xff49484b),
                        fontSize: SizeConfig
                                .safeBlockVertical *
                            24),
              ),
              SizedBox(height: 20,),
              Center(
                child: TextField(
                            decoration: InputDecoration(
                                
                                contentPadding: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 10),
                                hintText: 'Enter the docId',
                                hintStyle: TextStyle(color: Colors.black)),
                            onChanged: (value) {
                              docId = value;
                            },
                          ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'Add doc id',
                onTap: ()async{
                  await Provider.of<Doctors>(context,listen: false).addDoctor(Provider.of<Auth>(context,listen: false).token, docId);
                  Navigator.pop(context);
                  setState(() {
                                      
                                    });
                },
              )
            ],
          ),
        ),
      ),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffb793da),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (ctx, index) {
                    print(doctors[index].name);
                    return doctors.length == 0
                        ? Container(
                            child: Center(
                            child: Text('No doctors added'),
                          ))
                        : Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal*20,vertical: SizeConfig.safeBlockVertical*10),
                          child: Container(
                            
                            height: SizeConfig.safeBlockVertical *120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffe7cdf8),
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
                                            '${doctors[index].name}',
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
                                            '${doctors[index].email}',
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
                                            '${doctors[index].phone}',
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
                        );
                  })),
    );
  }
}
