import 'package:weather/layers/data/model/condition.dart';

List<WeatherInfo> getListOfWeatherInfo(List<dynamic> json) => List.from(json.map((e) => WeatherInfo.fromJson(e)).toList());

class WeatherInfo {
  final String? time;
  final Condition condition;
  final int temp_c;
  final int wind_kph;
  final int humidity;

  WeatherInfo({required this.condition, required this.temp_c, required this.wind_kph, required this.humidity, this.time});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      time: json['time'] ?? null,
      condition: Condition.fromJson(json["condition"]),
      temp_c: json["temp_c"].ceil(),
      wind_kph: json["wind_kph"].ceil(),
      humidity: json["humidity"].ceil(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "condition": this.condition,
      "temp_c": this.temp_c,
      "wind_kph": this.wind_kph,
      "humidity": this.humidity,
    };
  }
}