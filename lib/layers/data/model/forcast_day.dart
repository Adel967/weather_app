import 'package:weather/layers/data/model/day_weather.dart';

List<ForCastDay> getListOfForCastDayInfo(List<dynamic> json) => List.from(json.map((e) => ForCastDay.fromJson(e)).toList());

class ForCastDay {

  final DayWeather dayWeather;
  final String date;

  ForCastDay({required this.dayWeather, required this.date});

  factory ForCastDay.fromJson(dynamic json) {
    return ForCastDay(
      dayWeather: DayWeather.fromJson(json["day"]),
      date: json["date"],
    );
  }

}