import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/core/loaders/loading_overlay.dart';
import 'package:weather/core/ui/waiting_widget.dart';
import 'package:weather/layers/data/model/forcast.dart';
import 'package:weather/layers/logic/animated_background/animated_background_cubit.dart';
import 'package:weather/layers/logic/forcast/forcast_cubit.dart';
import 'package:weather/core/enums.dart' as Enums;
import 'package:weather/layers/logic/week_weather/week_weather_cubit.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/current_weather_page.dart';
import 'package:weather/layers/presentation/screens/home_screen/widgets/forcast_days_page.dart';
import 'package:weather/layers/presentation/widgets/animated_background.dart';
import '../../../../core/enums.dart';
import '../../../../injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController;
  late Animation _textAnimation1;
  late Animation _textAnimation2;

  final ForcastCubit forcastCubit = sl<ForcastCubit>();
  final WeekWeatherCubit weekWeatherCubit = sl<WeekWeatherCubit>();
  AnimatedBackgroundCubit animatedBackgroundCubit =
      sl.get<AnimatedBackgroundCubit>();
  ItemScrollController scrollController = ItemScrollController();
  int indexOfCurrentTime = 0;
  late ForCast forCast;
  bool refreshing = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _textAnimation1 =
        ColorTween(begin: Color(0XFFfcd232), end: Color(0XFFfcd232))
            .animate(_controller);
    _textAnimation2 =
        ColorTween(begin: Color(0XFFe3a313), end: Color(0XFFe3a313))
            .animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    _pageController = PageController(initialPage: 0);
    animatedBackgroundCubit.setBackgroundLoading();
    forcastCubit.getUserLocationForcast();
  }

  startAnimatedBackground(WeatherConditions weatherConditions) {
    Future.delayed(Duration(milliseconds: 200), () {
      animatedBackgroundCubit.setBackgroundState(weatherConditions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AnimatedBackgroundCubit, AnimatedBackgroundState>(
        bloc: animatedBackgroundCubit,
        listener: (context, state) {
          if (state is AnimatedBackgroundLoaded) {
            if (state.backgroundColorType ==
                BackgroundColorType.LIGHT_TO_DARK) {
              _textAnimation1 =
                  ColorTween(begin: Color(0XFFfcd232), end: Color(0XFFf9fbfd))
                      .animate(_controller);
              _textAnimation2 =
                  ColorTween(begin: Color(0XFFe3a313), end: Color(0XFFb0d3fa))
                      .animate(_controller);
              _controller.reset();
            } else if (state.backgroundColorType ==
                BackgroundColorType.DARK_TO_LIGHT) {
              _textAnimation1 =
                  ColorTween(begin: Color(0XFFf9fbfd), end: Color(0XFFfcd232))
                      .animate(_controller);
              _textAnimation2 =
                  ColorTween(begin: Color(0XFFb0d3fa), end: Color(0XFFe3a313))
                      .animate(_controller);
              _controller.reset();
            }
            _controller.forward();
          }
        },
        child: BlocConsumer<ForcastCubit, ForcastState>(
          bloc: forcastCubit,
          listener: (context, state) {
            if (state is ForcastRefreshing) {
              LoadingOverlay.of(context).show();
              refreshing = true;
            } else if (state is ForcastLoaded) {
              if (refreshing == true) {
                LoadingOverlay.of(context).hide();
                refreshing = false;
              }
              weekWeatherCubit.setWeekWeather(state.forCast.forCastDay);
              forCast = state.forCast;
              setState(() {});
              startAnimatedBackground(
                  state.forCast.current.condition.weatherType);
              Future.delayed(Duration(seconds: 1), () {
                state.forCast.hours.forEach((e) {
                  if (checkCurrentTime(e.time.toString())) {
                    indexOfCurrentTime = state.forCast.hours.indexOf(e);
                  }
                });
                if (indexOfCurrentTime != 0) {
                  scrollController.scrollTo(
                      index: indexOfCurrentTime,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                      alignment: 0);
                }
              });
            }
          },
          builder: (context, state) {
            if (state is ForcastLoading) {
              return WaitingWidget();
            } else if (state is ForcastError) {
              return Center(
                child: Text(state.exception.message.toString()),
              );
            } else {
              return Stack(
                children: [
                  AnimatedBackground(),
                  Positioned.fill(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        SafeArea(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getDeviceType(context) ==
                                          Enums.DeviceType.TABLET
                                      ? 40
                                      : 10.0),
                              child: CurrentWeatherPage(
                                forCast: forCast,
                                scrollController: scrollController,
                                refreshForcast: (location) =>
                                    forcastCubit.refreshForcast(location),
                                firstColor: _textAnimation1.value,
                                secondColor: _textAnimation2.value,
                                moveToNext: () {
                                  _pageController.jumpToPage(1);
                                  startAnimatedBackground(forCast
                                      .forCastDay[
                                          weekWeatherCubit.state.currentIndex!]
                                      .dayWeather
                                      .condition
                                      .weatherType);
                                },
                              )),
                        ),
                        SafeArea(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getDeviceType(context) ==
                                          Enums.DeviceType.TABLET
                                      ? 40
                                      : 10.0),
                              child: ForCastDaysPage(
                                moveToPrevious: () {
                                  _pageController.jumpToPage(0);
                                  startAnimatedBackground(
                                      forCast.current.condition.weatherType);
                                },
                                firstColor: _textAnimation1.value,
                                secondColor: _textAnimation2.value,
                                changeBackground: startAnimatedBackground,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
