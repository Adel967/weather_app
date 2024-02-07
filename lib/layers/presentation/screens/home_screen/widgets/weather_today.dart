import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/enums.dart' as Enums;

import '../../../../../core/configurations/assets.dart';
import '../../../../../core/constants.dart';
import 'gradiant_text.dart';

class WeatherToday extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;

  const WeatherToday({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400, height: 1, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: CachedNetworkImage(
            imageUrl: "https:${imagePath}",
          ),
        ),
        Expanded(
          flex: 1,
          child: GradientText(
            subTitle,
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0XFFfcd232), Color(0XFFe3a313)]),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
