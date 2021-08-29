import 'package:flutter/material.dart';
import 'package:shealth/UI/sizeconfig.dart';
import 'package:shealth/routers/RouteNames.dart';

import 'custombutton.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xffF3F1F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registration Successful',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: Color(0xff49484b),
                    fontSize: SizeConfig.safeBlockVertical * 24),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.check,
                color: Colors.greenAccent,
                size: SizeConfig.safeBlockVertical * 32,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Go to home',
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.homepage);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
