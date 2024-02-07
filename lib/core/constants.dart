import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/enums.dart';

DeviceType getDeviceType(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  return useMobileLayout ? DeviceType.PHONE :DeviceType.TABLET;
}

String getDayOfWeek({DateTime? date}){
  DateTime dateTime = date ?? DateTime.now();
  return DateFormat('EEEE').format(dateTime);
}

String getCurrentTime(){
  DateTime dateTime = DateTime.now();
  return DateFormat('HH:mm').format(dateTime);
}

String getTime(String date){
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('HH:mm').format(dateTime);
}

bool checkCurrentTime(String time) {
  return getTime(time).split(":")[0] == getCurrentTime().split(":")[0]
      ? true
      : false;
}

getWeatherFromTemp(int temp){
  if(temp >= 35){
    return "Very Hot";
  }else if(temp < 35 && temp >= 30){
    return "Hot";
  }else if(temp < 30 && temp >= 26){
    return "Normal";
  }else if(temp < 26 && temp >= 18){
    return "Cold";
  }else{
    return "Pretty Cold";
  }
}