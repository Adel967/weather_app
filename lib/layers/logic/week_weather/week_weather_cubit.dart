import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/forcast_day.dart';
part 'week_weather_state.dart';

class WeekWeatherCubit extends Cubit<WeekWeather> {
  WeekWeatherCubit() : super(WeekWeather());

  setWeekWeather(List<ForCastDay> weekWeather){
    emit(WeekWeather(currentIndex: 0, forCastDays: weekWeather));
  }

  nextDay(){
    if(state.currentIndex != 6){
      emit(state.copyWith(currentIndex: state.currentIndex! + 1));
    }
  }

  previousDay(){
    if(state.currentIndex != 0){
      emit(state.copyWith(currentIndex: state.currentIndex! -1));
    }
  }
}
