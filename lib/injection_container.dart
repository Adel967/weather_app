import 'package:get_it/get_it.dart';
import 'package:weather/layers/data/repository/weather_repositiory.dart';
import 'package:weather/layers/logic/animated_background/animated_background_cubit.dart';
import 'package:weather/layers/logic/forcast/forcast_cubit.dart';
import 'package:weather/layers/logic/location/location_cubit.dart';
import 'package:weather/layers/logic/week_weather/week_weather_cubit.dart';

import 'core/dio/factory.dart';

final sl = GetIt.instance;

void initInjection(){
  sl.registerLazySingleton(() => DioFactory.create());

  //bloc
  sl.registerLazySingleton(() => ForcastCubit(sl()));
  sl.registerLazySingleton(() => LocationCubit(sl()));
  sl.registerLazySingleton(() => AnimatedBackgroundCubit());
  sl.registerLazySingleton(() => WeekWeatherCubit());

  //repository
  sl.registerLazySingleton(() => WeatherRepository());

}