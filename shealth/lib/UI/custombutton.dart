import 'package:flutter/material.dart';
import 'package:shealth/UI/sizeconfig.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
    {
      this.text,
      this.onTap,
    }
  );
  final text;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig. safeBlockVertical * 50,
        width: SizeConfig.safeBlockHorizontal*200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffe7cdf8),
        ),
        child: Center(
          child: Text(
            '$text',
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Color(0xff49484b),
                  fontSize: SizeConfig.safeBlockVertical * 24
                ),
          ),
        ),
      ),
    );
  }
}