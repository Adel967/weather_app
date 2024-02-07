import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/core/enums.dart';

import '../../../core/configurations/assets.dart';

part 'animated_background_state.dart';

class AnimatedBackgroundCubit extends Cubit<AnimatedBackgroundState> {
  AnimatedBackgroundCubit() : super(AnimatedBackgroundInitial());
  bool _cloudy = false;
  bool _someClouds = false;
  bool _rainy = false;
  bool _snowy = false;
  bool _thundery = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioPlayer audioPlayer1 = AudioPlayer();
  late WeatherConditions weatherConditions ;
  late BackgroundColorType backgroundColorType;

  setBackgroundState(WeatherConditions weatherConditions) {
    this.weatherConditions = weatherConditions;
    this.backgroundColorType = BackgroundColorType.SAME;
    if(weatherConditions == WeatherConditions.RAINY && !_rainy){
      rainyAnimation();
    }else if(weatherConditions == WeatherConditions.SNOWY && !_snowy){
      snowyAnimation();
    }else{
      setWeatherParameters();
      changeAnimatedBackgroundState();
    }

  }

  changeAnimatedBackgroundState(){
    emit(AnimatedBackgroundLoaded(
        weatherConditions: weatherConditions,
        backgroundColorType: backgroundColorType,
        cloudy: _cloudy,
        someClouds: _someClouds,
        rainy: _rainy,
        snowy: _snowy,
        thundery: _thundery));
    backgroundColorType = BackgroundColorType.SAME;
  }

  setBackgroundLoading() {
    emit(AnimatedBackgroundLoading());
  }

  rainyAnimation(){
    bool isCloudy = _cloudy;
    if(!_cloudy){
      cloudyValues();
      changeAnimatedBackgroundState();
    }
    Future.delayed(Duration(seconds: isCloudy ? 0 : 5),(){
      thunderValues();
      changeAnimatedBackgroundState();
      audioPlayer.play(AssetSource(Assets.THUNDER_SOUND));
      Future.delayed(Duration(seconds: 2),(){
        setWeatherParameters();
        changeAnimatedBackgroundState();
        audioPlayer1.play(AssetSource(Assets.RAIN_SOUND));
      });
    });
  }

  snowyAnimation(){
    bool isCloudy = _cloudy;
    if(!_cloudy){
      cloudyValues();
      changeAnimatedBackgroundState();
    }
    Future.delayed(Duration(seconds: isCloudy ? 0 : 5),(){
      thunderValues();
      changeAnimatedBackgroundState();
      audioPlayer.play(AssetSource(Assets.THUNDER_SOUND));
      Future.delayed(Duration(seconds: 2),(){
        setWeatherParameters();
        changeAnimatedBackgroundState();
      });
    });
  }

  cloudyValues(){
    if(!_cloudy){
      backgroundColorType = BackgroundColorType.LIGHT_TO_DARK;
    }
    _cloudy = true;
    _someClouds = false;
    _rainy = false;
    _snowy = false;
    _thundery = false;
  }

  thunderValues(){
    _cloudy = true;
    _thundery = true;
    _someClouds = false;
    _rainy = false;
    _snowy = false;
  }

  setWeatherParameters() {
    switch (weatherConditions) {
      case WeatherConditions.SUNNY:
        if(_cloudy){
          backgroundColorType = BackgroundColorType.DARK_TO_LIGHT;
        }
        _cloudy = false;
        _someClouds = false;
        _rainy = false;
        _snowy = false;
        _thundery = false;
        audioPlayer.setVolume(1);
        audioPlayer.play(AssetSource(Assets.CLEAR_SOUND));
      case WeatherConditions.CLOUDY:
        cloudyValues();
      case WeatherConditions.SUNNY_WITH_CLOUDS:
        if(_cloudy){
          backgroundColorType = BackgroundColorType.DARK_TO_LIGHT;
        }
        _cloudy = false;
        _someClouds = true;
        _rainy = false;
        _snowy = false;
        _thundery = false;
        audioPlayer.setVolume(1);
        audioPlayer.play(AssetSource(Assets.CLEAR_SOUND));
      case WeatherConditions.SNOWY:
        _cloudy = true;
        _someClouds = false;
        _rainy = false;
        _snowy = true;
        _thundery = false;
      case WeatherConditions.RAINY:
        _cloudy = true;
        _someClouds = false;
        _rainy = true;
        _snowy = false;
        _thundery = false;
      case WeatherConditions.THUNDERY:
        thunderValues();
    }
  }
}
