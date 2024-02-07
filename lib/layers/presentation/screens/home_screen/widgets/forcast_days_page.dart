import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/layers/logic/week_weather/week_weather_cubit.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/gradiant_text.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/weather_information.dart';
import 'package:weather/core/enums.dart' as Enums;
import 'package:weather/layers/presentation/widgets/glass_container.dart';
import '../../../../../core/configurations/assets.dart';
import '../../../../../core/constants.dart';
import '../../../../../injection_container.dart';
import '../../../../data/model/forcast_day.dart';

class ForCastDaysPage extends StatefulWidget {
  ForCastDaysPage(
      {super.key,
      required this.moveToPrevious,
      required this.firstColor,
      required this.secondColor,
      required this.changeBackground});

  final VoidCallback moveToPrevious;
  final Color firstColor;
  final Color secondColor;
  final void Function(Enums.WeatherConditions) changeBackground;

  @override
  State<ForCastDaysPage> createState() => _ForCastDaysPageState();
}

class _ForCastDaysPageState extends State<ForCastDaysPage> {
  int currentIndex = 0;
  final WeekWeatherCubit weekWeatherCubit = sl<WeekWeatherCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: BlocBuilder<WeekWeatherCubit, WeekWeather>(
        bloc: weekWeatherCubit,
        builder: (context, state) {
          ForCastDay forCast = state.forCastDays![state.currentIndex!];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => widget.moveToPrevious(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "Next 7 Days",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 90.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.currentIndex == 0
                        ? "Tomorrow"
                        : getDayOfWeek(date: DateTime.tryParse(forCast.date)),
                    style: TextStyle(
                        color: Color(0XFFfdfdfe),
                        fontSize: 120.sp,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                              blurRadius: 6.0,
                              offset: Offset(0.5, 0.5),
                              color: Colors.black),
                        ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      default_button(() {
                        if (state.currentIndex != 0) {
                          widget.changeBackground(state
                              .forCastDays![state.currentIndex! - 1]
                              .dayWeather
                              .condition
                              .weatherType);
                          weekWeatherCubit.previousDay();
                        }
                      }, Icons.arrow_back,
                          state.currentIndex != 0 ),
                      SizedBox(
                        width: 20,
                      ),
                      default_button(() {
                        if (state.currentIndex != 6) {
                          widget.changeBackground(state
                              .forCastDays![state.currentIndex! + 1]
                              .dayWeather
                              .condition
                              .weatherType);
                          weekWeatherCubit.nextDay();
                        }
                      }, Icons.arrow_forward,
                          state.currentIndex != 6),
                    ],
                  )
                ],
              ),
              Text(
                forCast.dayWeather.condition.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1,
                    shadows: [
                      Shadow(
                          blurRadius: 6.0,
                          offset: Offset(0.5, 0.5),
                          color: Colors.black),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GradientText(
                              "${forCast.dayWeather.maxtemp_c}°",
                              gradient: LinearGradient(
                                colors: [widget.firstColor, widget.secondColor],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              style: TextStyle(
                                  fontSize: 280.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                  letterSpacing: -6),
                            ),
                            GradientText(
                              getWeatherFromTemp(forCast.dayWeather.maxtemp_c),
                              gradient: LinearGradient(
                                colors: [widget.firstColor, widget.secondColor],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              style: TextStyle(
                                fontSize: 70.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                            Text(
                              "From: ${forCast.dayWeather.mintemp_c}° to ${forCast.dayWeather.maxtemp_c}°",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            WeatherInformation(
                              imagePath: Assets.WIND_SPEED_ICON,
                              title: "${forCast.dayWeather.maxwind_kph}km/h",
                              subTitle: "Wind",
                              iconSize: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            WeatherInformation(
                              imagePath: Assets.HUMIDITY_ICON,
                              title: "${forCast.dayWeather.avghumidity}%",
                              subTitle: "Humidity",
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image.asset(
                      height: getDeviceType(context) == Enums.DeviceType.TABLET
                          ? 500.w
                          : 100,
                      width: getDeviceType(context) == Enums.DeviceType.TABLET
                          ? 500.w
                          : 120,
                      "assets/images/${forCast.dayWeather.condition.name.toString().toLowerCase().replaceAll(" ", "")}.png",
                      errorBuilder: (ctx, error, stackTrace) => Image.network(
                        'https:${forCast.dayWeather.condition.iconUrl}',
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GlassContainer(
                  height: 0,
                  width: double.infinity,
                  withBorder: true,
                  padding: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      ForCastDay forCast = state.forCastDays![index];
                      return weekWeather(
                        getDayOfWeek(date: DateTime.tryParse(forCast.date))
                            .substring(0, 3),
                        Enums.getWeatherConditionName(
                            forCast.dayWeather.condition.weatherType),
                        forCast.dayWeather.condition.iconUrl,
                        "${forCast.dayWeather.mintemp_c}°/${forCast.dayWeather.maxtemp_c}°",
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget weekWeather(
      String weekDay, String weatherCondition, String imageUrl, String temp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            weekDay,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: CachedNetworkImage(
              imageUrl: "https:${imageUrl}",
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            weatherCondition,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            temp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget default_button(VoidCallback fun, IconData icon, bool clickAble) {
    return InkWell(
      onTap: () => fun(),
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Color(0xFF6789b6),
            borderRadius: BorderRadius.circular(10),
            gradient: clickAble
                ? LinearGradient(
                    colors: [Color(0XFF6191cf), Color(0XFFb1cdf6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                : null),
        child: Icon(
          icon,
          color: clickAble ? Colors.white : Colors.grey.shade400,
          size: 30,
        ),
      ),
    );
  }
}
