import 'package:weather/core/enums.dart';

class Condition {
  final String name;
  final String iconUrl;
  final WeatherConditions weatherType;

  Condition({required this.name, required this.weatherType, required this.iconUrl});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      name: json["text"],
      iconUrl: json["icon"],
      weatherType: getWeatherConditionByString(json['text']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "weatherType": this.weatherType,
      "icon": this.iconUrl
    };
  }
}