import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/enums.dart' as Enums;
import '../../../../../core/configurations/assets.dart';
import '../../../../../core/constants.dart';

class WeatherInformation extends StatelessWidget {

  final String imagePath;
  final String title;
  final String subTitle;
  final double? iconSize;

  const WeatherInformation({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.iconSize
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: iconSize != null ? iconSize : getDeviceType(context) ==  Enums.DeviceType.TABLET ? 70.sp : 40,
          width:  iconSize != null ? iconSize : getDeviceType(context) ==  Enums.DeviceType.TABLET ? 70.sp : 40,
        ),
        SizedBox(height: 5,),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
              color: Colors.white.withOpacity(.8),
              fontSize: 35.sp
          ),
        ),
      ],
    );
  }
}
