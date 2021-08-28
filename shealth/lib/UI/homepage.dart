import 'package:flutter/material.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xffF3F1F5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'Shealth',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 48,
                color: Color(0xff49484b),
              ),
            ),
          ),
          Container(

            child: Text(
              'Share your health',
              style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: SizeConfig.safeBlockVertical * 16,
                color: Color(0xff49484b),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical*20),
              width: SizeConfig.safeBlockHorizontal * 300,
              height: SizeConfig.safeBlockVertical * 300,
              child: SvgPicture.network(
                'https://raw.githubusercontent.com/rdotjain/hackx-shealth/Web/client/src/assets/images/medical2.svg?token=ARKWUJTBQWHR7Y5MU6RC5ITBGM4DQ',
              ),
            ),
          ),
          Container(
            height: SizeConfig. safeBlockVertical * 50,
            width: SizeConfig.safeBlockHorizontal*200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe7cdf8),
            ),
            child: Center(
              child: Text(
                'Log In',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Color(0xff49484b),
                      fontSize: SizeConfig.safeBlockVertical * 20
                    ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: SizeConfig. safeBlockVertical * 50,
            width: SizeConfig.safeBlockHorizontal*200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffe7cdf8),
            ),
            child: Center(
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Color(0xff49484b),
                      fontSize: SizeConfig.safeBlockVertical * 20
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
