import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/layers/data/model/location.dart';

import '../../data/repository/weather_repositiory.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._weatherRepository) : super(LocationInitial());

  final WeatherRepository _weatherRepository;

  getLocations(String text) async{
    final locations = await _weatherRepository.getLocation(text);
    locations.fold((l) => null, (r) => emit(LocationLoaded(r)));
  }

  resetLocations(){
    emit(LocationInitial());
  }
}
