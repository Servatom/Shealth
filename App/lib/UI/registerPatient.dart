import 'package:flutter/material.dart';
import 'package:shealth/UI/custombutton.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:shealth/providers/auth.dart';

import 'customdialog.dart';

class RegisterPatient extends StatelessWidget {
  late String name;
  late String email;
  late String age;
  late String gender;
  late String phNo;
  late String password;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xffF3F1F5),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffb793da),
          title: Container(
            child: Text(
              'Register Patient',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: SizeConfig.safeBlockVertical * 24,
                    color: Color(0xff49484b),
                  ),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 20,
              top: SizeConfig.safeBlockVertical * 40),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: SizeConfig.safeBlockVertical * 20,
                            color: Color(0xff49484b),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.screenWidth / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff7f7c82).withOpacity(.34)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 10),
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(color: Colors.black)),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: SizeConfig.safeBlockVertical * 20,
                            color: Color(0xff49484b),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.screenWidth / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff7f7c82).withOpacity(.34)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 10),
                            hintText: 'Enter your phone number',
                            hintStyle: TextStyle(color: Colors.black)),
                        onChanged: (value) {
                          phNo = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: SizeConfig.safeBlockVertical * 20,
                            color: Color(0xff49484b),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.screenWidth / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff7f7c82).withOpacity(.34)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 10),
                            hintText: 'Enter your age',
                            hintStyle: TextStyle(color: Colors.black)),
                        onChanged: (value) {
                          age = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            fontSize: SizeConfig.safeBlockVertical * 20,
                            color: Color(0xff49484b),
                          ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: SizeConfig.screenWidth / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff7f7c82).withOpacity(.34)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal * 10),
                            hintText: 'Enter your Gender (M, F, O)',
                            hintStyle: TextStyle(color: Colors.black)),
                        onChanged: (value) {
                          gender = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(
                                  fontSize: SizeConfig.safeBlockVertical * 20,
                                  color: Color(0xff49484b),
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: SizeConfig.screenWidth / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff7f7c82).withOpacity(.34)),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left:
                                          SizeConfig.safeBlockHorizontal * 10),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(color: Colors.black)),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(
                                  fontSize: SizeConfig.safeBlockVertical * 20,
                                  color: Color(0xff49484b),
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: SizeConfig.screenWidth / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff7f7c82).withOpacity(.34)),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left:
                                          SizeConfig.safeBlockHorizontal * 10),
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(color: Colors.black)),
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 15),
                      child: Center(
                        child: CustomButton(
                            text: 'Register',
                            onTap: () async {
                              try {
                                await Provider.of<Auth>(context, listen: false)
                                    .registerPatient(name, email, phNo, gender,
                                        age, password);

                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CustomDialog();
                                    });
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text('Error Occured'),
                                        content: Text('$e'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Ok'))
                                        ],
                                      );
                                    });
                              }
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
