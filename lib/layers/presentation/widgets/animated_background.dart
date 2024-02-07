import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:weather/layers/logic/animated_background/animated_background_cubit.dart';
import '../../../core/configurations/assets.dart';
import '../../../core/constants.dart';
import '../../../core/enums.dart';
import '../../../injection_container.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin{
  late AnimationController _controller ;
  late Animation _bgAnimation1 ;
  late Animation _bgAnimation2 ;
  Rive.SMIInput<bool>? _cloudy;
  Rive.SMIInput<bool>? _someClouds;
  Rive.SMIInput<bool>? _thunder;
  Rive.Artboard? _weatherArtboard;

  final animatedBackgroundCubit = sl<AnimatedBackgroundCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load(Assets.WEATHER_ANIMATION).then((data) {
      final file = Rive.RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller =
          Rive.StateMachineController.fromArtboard(artboard, 'weather');
      if (controller != null) {
        artboard.addController(controller);
        _cloudy = controller.findInput('cloudy')!;
        _someClouds = controller.findInput('someClouds')!;
        _thunder = controller.findInput('thunder')!;
      }
      setState(() {
        _weatherArtboard = artboard;
      });
    });
    _controller = AnimationController(
        duration: Duration(seconds: 3),
        vsync: this
    );
    _bgAnimation1 = ColorTween(begin: Color(0xFF2852e0),end: Color(0xFF2852e0)).animate(_controller);
    _bgAnimation2 = ColorTween(begin: Color(0xFF6e9de2),end: Color(0xFF6e9de2)).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AnimatedBackgroundCubit, AnimatedBackgroundState>(
      bloc: animatedBackgroundCubit,
      listener: (context, state) {
        if (state is AnimatedBackgroundLoaded) {
          if(state.backgroundColorType == BackgroundColorType.LIGHT_TO_DARK){
            _bgAnimation1 = ColorTween(begin: Color(0xFF2852e0),end: Color(0XFF455790)).animate(_controller);
            _bgAnimation2 = ColorTween(begin: Color(0xFF6e9de2),end: Color(0XFF7b8bc0)).animate(_controller);
            _controller.reset();
          }else if(state.backgroundColorType == BackgroundColorType.DARK_TO_LIGHT){
            _bgAnimation1 = ColorTween(begin: Color(0XFF455790),end: Color(0xFF2852e0)).animate(_controller);
            _bgAnimation2 = ColorTween(begin: Color(0XFF7b8bc0),end: Color(0xFF6e9de2)).animate(_controller);
            _controller.reset();
          }
          _controller.forward();
          _cloudy?.value = state.cloudy;
          _someClouds?.value = state.someClouds;
          _thunder?.value = state.thundery;
        }
      },
      builder: (context, state) {
        if(state is AnimatedBackgroundLoading){
          return Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    //colors: [Colors.orange.shade200,Color(0XFF2852df),Color(0XFF2852df),Color(0XFF70a0e3) ],
                    colors: [_bgAnimation1.value,_bgAnimation2.value],
                  ),
                ),
              ),
              _weatherArtboard != null
                  ? SizedBox(
                  height: size.height * 0.6,
                  width: size.width,
                  child: Rive.Rive(
                    artboard: _weatherArtboard!,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ))
                  : SizedBox(),
            ],
          );
        }else if(state is AnimatedBackgroundLoaded){
          return Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    //colors: [Colors.orange.shade200,Color(0XFF2852df),Color(0XFF2852df),Color(0XFF70a0e3) ],
                    colors: [_bgAnimation1.value,_bgAnimation2.value],
                  ),
                ),
              ),
              state.snowy
                  ? SizedBox(
                  height: size.height * 0.5,
                  width: size.width,
                  child: Rive.RiveAnimation.asset(
                    Assets.SNOWY_WEATHER_ANIMATION,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ))
                  : SizedBox(),
              _weatherArtboard != null
                  ? SizedBox(
                  height: size.height * 0.6,
                  width: size.width,
                  child: Rive.Rive(
                    artboard: _weatherArtboard!,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ))
                  : SizedBox(),
              Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX:
                        getDeviceType(context) == DeviceType.TABLET ? 20 : 8,
                        sigmaY:
                        getDeviceType(context) == DeviceType.TABLET ? 15 : 8),
                    child: SizedBox(),
                  )),
              state.rainy
                  ? Center(
                child: SizedBox(
                    height: size.height * 0.6,
                    width: size.width,
                    child: Rive.RiveAnimation.asset(
                      Assets.RAINY_WEATHER_ANIMATION,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    )),
              )
                  : SizedBox(),
            ],
          );
        }else{
          return SizedBox();
        }
      },
    );
  }
}
