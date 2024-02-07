part of 'week_weather_cubit.dart';


class WeekWeather extends Equatable {

  final int? currentIndex;
  final List<ForCastDay>? forCastDays;

  WeekWeather({this.currentIndex, this.forCastDays});


  @override
  // TODO: implement props
  List<Object?> get props => [this.currentIndex, this.forCastDays];

  WeekWeather copyWith({
    int? currentIndex,
    List<ForCastDay>? forCastDays,
  }) {
    return WeekWeather(
      currentIndex: currentIndex ?? this.currentIndex,
      forCastDays: forCastDays ?? this.forCastDays,
    );
  }
}

