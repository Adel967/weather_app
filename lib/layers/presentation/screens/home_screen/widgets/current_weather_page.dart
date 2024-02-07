import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather/core/enums.dart' as Enums;
import 'package:weather/layers/data/model/forcast.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/weather_information.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/weather_today.dart';
import 'package:weather/layers/presentation/widgets/glass_container.dart';

import '../../../../../core/configurations/assets.dart';
import '../../../../../core/constants.dart';
import '../../../../data/model/weather_info.dart';
import '../../../widgets/custom_search.dart';
import 'gradiant_text.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage(
      {super.key,
      required this.forCast,
      required this.scrollController,
      required this.refreshForcast(String),
      required this.firstColor,
      required this.secondColor,
      required this.moveToNext});

  final ForCast forCast;
  final ItemScrollController scrollController;
  final void Function(String location) refreshForcast;
  final VoidCallback moveToNext;
  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: CustomSearch())
                        .then((value) {
                      if (value != null) {
                        refreshForcast(value);
                      }
                    });
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1)
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Search for a city",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${getDayOfWeek()} ${getCurrentTime()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 6.0,
                            offset: Offset(0.5, 0.5),
                            color: Colors.black),
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  forCast.location.country,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      shadows: [
                        Shadow(
                            blurRadius: 6.0,
                            offset: Offset(0.5, 0.5),
                            color: Colors.black),
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      forCast.location.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 140.sp,
                          height: 1,
                          shadows: [
                            Shadow(
                                blurRadius: 6.0,
                                offset: Offset(0.5, 0.5),
                                color: Colors.black),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GlassContainer(
                  width: size.width * 0.8,
                  height: getDeviceType(context) == Enums.DeviceType.TABLET
                      ? size.width * 0.35
                      : size.width * 0.45,
                  withBorder: true,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: getDeviceType(context) == Enums.DeviceType.TABLET
                            ? -150
                            : -60,
                        left: 10,
                        child: Image.asset(
                          height:
                              getDeviceType(context) == Enums.DeviceType.TABLET
                                  ? 500.w
                                  : 150,
                          width:
                              getDeviceType(context) == Enums.DeviceType.TABLET
                                  ? 500.w
                                  : 170,
                          "assets/images/${forCast.current.condition.name.toString().toLowerCase().replaceAll(" ", "")}.png",
                          errorBuilder: (ctx, error, stackTrace) =>
                              Image.network(
                            'https:${forCast.current.condition.iconUrl}',
                            width: 170,
                            height: 170,
                            fit: BoxFit.fill,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 20,
                        child: GradientText(
                          forCast.current.condition.name,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [firstColor, secondColor]),
                          style: TextStyle(
                            fontSize: 80.sp,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(
                          top: getDeviceType(context) == Enums.DeviceType.TABLET
                              ? 50
                              : 35,
                          right:
                              getDeviceType(context) == Enums.DeviceType.TABLET
                                  ? 30
                                  : 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GradientText(
                                "${forCast.current.temp_c}°",
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [firstColor, secondColor]),
                                style: TextStyle(
                                    fontSize: 230.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    letterSpacing: -6),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: getDeviceType(context) == Enums.DeviceType.TABLET
                      ? 40
                      : 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherInformation(
                      imagePath: Assets.WIND_SPEED_ICON,
                      title: "${forCast.current.wind_kph}km/h",
                      subTitle: "Wind",
                    ),
                    WeatherInformation(
                      imagePath: Assets.SUNRISE_ICON,
                      title: forCast.astro.sunrise.split(' ')[0],
                      subTitle: forCast.astro.sunrise.split(' ')[1],
                    ),
                    WeatherInformation(
                      imagePath: Assets.SUNSET_ICON,
                      title: forCast.astro.sunset.split(' ')[0],
                      subTitle: forCast.astro.sunset.split(' ')[1],
                    ),
                    WeatherInformation(
                      imagePath: Assets.HUMIDITY_ICON,
                      title: "${forCast.current.humidity}%",
                      subTitle: "Humidity",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getDeviceType(context) == Enums.DeviceType.TABLET
                  ? 35.sp
                  : 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => moveToNext(),
                    child: Text(
                      "Next 7 Days",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 60.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getDeviceType(context) == Enums.DeviceType.TABLET
                  ? 35.sp
                  : 20.0),
          child: GlassContainer(
            height:
                getDeviceType(context) == Enums.DeviceType.TABLET ? 200 : 95,
            width: size.width,
            withBorder: true,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ScrollablePositionedList.builder(
                key: PageStorageKey(0),
                itemScrollController: scrollController,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemCount: forCast.hours.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  WeatherInfo weatherInfo = forCast.hours[index];
                  return Container(
                    margin: EdgeInsets.only(right: 25),
                    child: Center(
                      child: WeatherToday(
                          imagePath: weatherInfo.condition.iconUrl,
                          title: checkCurrentTime(weatherInfo.time!)
                              ? "Now"
                              : getTime(weatherInfo.time!),
                          subTitle: "${weatherInfo.temp_c}°"),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
