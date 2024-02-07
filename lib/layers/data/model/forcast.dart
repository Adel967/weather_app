import 'package:weather/layers/data/model/astronomy.dart';
import 'package:weather/layers/data/model/condition.dart';
import 'package:weather/layers/data/model/location.dart';
import 'package:weather/layers/data/model/weather_info.dart';

import 'forcast_day.dart';

class ForCast {
  final Location location;
  final Astronomy astro;
  final WeatherInfo current;
  final List<WeatherInfo> hours;
  final List<ForCastDay> forCastDay;

  ForCast({required this.location,
    required this.astro,
    required this.current,
    required this.hours,
    required this.forCastDay
  });

  factory ForCast.fromJson(dynamic json) =>
      ForCast(
          location: Location.fromJson(json["location"]),
          astro: Astronomy.fromJson(json['forecast']['forecastday'][0]['astro']),
          current: WeatherInfo.fromJson(json['current']),
          hours: getListOfWeatherInfo(json['forecast']['forecastday'][0]['hour']),
          forCastDay: getListOfForCastDayInfo(json['forecast']['forecastday'])
      );
}
