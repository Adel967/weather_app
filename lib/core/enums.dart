// api requests types
import 'dart:ui';

/// type of request : [RequestType.POST] or [RequestType.GET]
enum RequestType { GET, POST, PUT, DELETE }

enum DeviceType{PHONE, TABLET, BIG_TABLET}

enum WeatherConditions{SUNNY, CLOUDY, SUNNY_WITH_CLOUDS, SNOWY, RAINY, THUNDERY}

enum BackgroundColorType{LIGHT_TO_DARK, DARK_TO_LIGHT, SAME}

getWeatherConditionByString(String condition){
  WeatherConditions weatherConditions;
  if(condition.toLowerCase().contains("sunny")){
    weatherConditions = WeatherConditions.SUNNY;
  }else if(condition.toLowerCase().contains("rain")){
    weatherConditions = WeatherConditions.RAINY;
  }else if(condition.toLowerCase().contains("snow")){
    weatherConditions = WeatherConditions.SNOWY;
  }else if(condition.toLowerCase().contains("thunder")){
    weatherConditions = WeatherConditions.THUNDERY;
  }else if(condition.toLowerCase().contains("cloud")){
    weatherConditions = WeatherConditions.CLOUDY;
  }else{
    weatherConditions = WeatherConditions.SUNNY_WITH_CLOUDS;
  }
  return weatherConditions;
}

getWeatherConditionName(WeatherConditions weatherConditions){
  switch(weatherConditions) {

    case WeatherConditions.SUNNY:
      return "Sunny";
    case WeatherConditions.CLOUDY:
      return "Cloudy";
    case WeatherConditions.SUNNY_WITH_CLOUDS:
      return "Windy";
    case WeatherConditions.SNOWY:
      return "Snowy";
    case WeatherConditions.RAINY:
      return "Rainy";
    case WeatherConditions.THUNDERY:
      return "Thundery";
  }
}

List<Color> getBackgroundColorByCondition(WeatherConditions weatherConditions){
  switch(weatherConditions){
    case WeatherConditions.SUNNY:
    case WeatherConditions.SUNNY_WITH_CLOUDS:
      return [Color(0xFF2852e0),Color(0xFF6e9de2)];
    case WeatherConditions.CLOUDY:
    case WeatherConditions.SNOWY:
    case WeatherConditions.RAINY:
    case WeatherConditions.THUNDERY:
       return [Color(0XFF455790),Color(0XFF7b8bc0)];
  }
}

List<Color> getTextColorByCondition(WeatherConditions weatherConditions){
  switch(weatherConditions){
    case WeatherConditions.SUNNY:
    case WeatherConditions.SUNNY_WITH_CLOUDS:
      return [Color(0XFFfcd232),Color(0XFFe3a313)];
    case WeatherConditions.CLOUDY:
    case WeatherConditions.SNOWY:
    case WeatherConditions.RAINY:
    case WeatherConditions.THUNDERY:
      return [Color(0XFFf4f9fe),Color(0XFFb0d3fa)];
  }
}