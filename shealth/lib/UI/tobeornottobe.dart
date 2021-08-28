import 'package:flutter/material.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/routers/AppRoutes.dart';
import 'package:shealth/routers/RouteNames.dart';
import 'custombutton.dart';
class TobeOrNotToBe extends StatelessWidget {
  TobeOrNotToBe({required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    print(type);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xffF3F1F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Container(
              child: Text(
                'Who are you?',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: SizeConfig.safeBlockVertical * 32,
                  color: Color(0xff49484b),
                ),
              ),
            ),
            
            SizedBox(height: 40,),
            CustomButton(
              text: 'Doctor',
              onTap: (){
                if(type == 'register'){
                  Navigator.pushNamed(context, RouteNames.registerDoctor );
                }
                else{
                  Navigator.pushNamed(context, RouteNames.login);
                }
              }
            ),
            SizedBox(height: 20,),
            Container(

              child: Text(
                'Or',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontSize: SizeConfig.safeBlockVertical * 24,
                  color: Color(0xff49484b),
                ),
              ),
            ),
            SizedBox(height: 20,),
            CustomButton(
              text: 'Patient',
              onTap: (){
                if(type == 'register'){
                  Navigator.pushNamed(context, RouteNames.registerPatient );
                }
                else{
                  Navigator.pushNamed(context, RouteNames.login);
                }
              },

            )
          ],
        ),
      ),
    );
  }
}


