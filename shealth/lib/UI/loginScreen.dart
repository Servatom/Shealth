import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shealth/UI/custombutton.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/providers/auth.dart';
import 'package:shealth/routers/RouteNames.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final type;
  LoginScreen({this.type});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  bool isLoading = false;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffb793da),
          title: Container(
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: SizeConfig.safeBlockVertical * 24,
                    color: Color(0xff49484b),
                  ),
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteNames.homepage);
              })),
      body: SafeArea(
        child: Center(
          child: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 250,
                  height: SizeConfig.safeBlockVertical * 250,
                  child: SvgPicture.network(
                    'https://raw.githubusercontent.com/rdotjain/hackx-shealth/Web/client/src/assets/images/medical1.svg?token=ARKWUJUWMQORPJ4JD2OYWFLBGNP24',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
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
                            hintText: 'Enter your phone number',
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
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
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
                margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 15),
                child: Center(
                  child: CustomButton(
                      text: 'Login',
                      onTap: () async {
                        print(widget.type);
                        try{
                          setState(() {
                            isLoading = true;
                                                    });
                        await Provider.of<Auth>(context, listen: false)
                            .signIn(email, password,widget.type);
                        Navigator.pushNamed(context, RouteNames.ladning,);
                        }catch(e){
                          showDialog(context: context, builder: (_){
                            return AlertDialog(
                              title: Text('Error Occured'),
                              content: Text('$e'),
                              actions: [
                                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                              ],
                            );
                          });
                        }finally{
                          setState(() {
                            isLoading = false;
                                                    });
                        }
                      }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
