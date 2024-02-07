import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/layers/data/model/condition.dart';


@freezed
class DayWeather {
  DayWeather({
    required this.maxtemp_c,
    required this.mintemp_c,
    required this.maxwind_kph,
    required this.avghumidity,
    required this.condition,
  });

  final int maxtemp_c;
  final int mintemp_c;
  final int maxwind_kph;
  final int avghumidity;
  final Condition condition;

  factory DayWeather.fromJson(dynamic json) {
    return DayWeather(
      maxtemp_c: json["maxtemp_c"].round(),
      mintemp_c: json["mintemp_c"].round(),
      maxwind_kph: json["maxwind_kph"].round(),
      avghumidity: json["avghumidity"].round(),
      condition: Condition.fromJson(json["condition"]),
    );
  }
//
}
