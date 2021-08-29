import 'package:flutter/material.dart';
import 'package:shealth/UI/custombutton.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/routers/RouteNames.dart';

import 'customdialog.dart';

class RegisterDoctor extends StatelessWidget {
  late String name;
  late String email;
  late String speciality;
  late String phNo;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F1F5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffb793da),
        title: Container(
          child: Text(
            'Register',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
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
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
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
                              keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phNo = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Speciality',
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
                              hintText: 'Enter your speciality',
                              hintStyle: TextStyle(color: Colors.black)),
                          onChanged: (value) {
                            speciality = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
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
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
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
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 15),
                  child: Center(
                    child: CustomButton(
                        text: 'Register',
                        onTap: () async {
                          await Provider.of<Auth>(context,listen: false).registerDoctor(
                              name, email, phNo, speciality, password);
                          showDialog(
                              context: context,
                              builder: (_) {
                                return CustomDialog();
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

