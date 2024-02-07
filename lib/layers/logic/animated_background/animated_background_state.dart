part of 'animated_background_cubit.dart';

@immutable
abstract class AnimatedBackgroundState extends Equatable{}

class AnimatedBackgroundInitial extends AnimatedBackgroundState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AnimatedBackgroundLoading extends AnimatedBackgroundState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AnimatedBackgroundLoaded extends AnimatedBackgroundState {
  WeatherConditions weatherConditions;
  BackgroundColorType backgroundColorType;
  bool cloudy = false;
  bool someClouds = false;
  bool rainy = false;
  bool snowy = false;
  bool thundery = false;

  AnimatedBackgroundLoaded({
    required this.weatherConditions,
    required this.backgroundColorType,
    required this.cloudy,
    required this.someClouds,
    required this.rainy,
    required this.snowy,
    required this.thundery,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.cloudy, this.someClouds, this.rainy, this.snowy, this.thundery];
}


