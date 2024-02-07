import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:weather/core/exceptions/app_exception.dart';
import 'package:weather/layers/data/model/forcast.dart';
import 'package:weather/layers/data/repository/weather_repositiory.dart';
import '../../../core/network.dart';

part 'forcast_state.dart';

class ForcastCubit extends Cubit<ForcastState> {
  ForcastCubit(this._weatherRepository) : super(ForcastInitial());

  final WeatherRepository _weatherRepository;

  getForcast(String location) async {
    emit(ForcastLoading());
    final res = await _weatherRepository.getForcast(location!);
    res.fold((l) => emit(ForcastError(l)), (r) => emit(ForcastLoaded(r)));
  }

  refreshForcast(String location) async {
    emit(ForcastRefreshing());
    final res = await _weatherRepository.getForcast(location!);
    res.fold((l) => emit(ForcastError(l)), (r) => emit(ForcastLoaded(r)));
  }

  getUserLocationForcast() async{
    emit(ForcastLoading());
    final res = await _weatherRepository.getForcast(await getCountry());
    res.fold((l) => emit(ForcastError(l)), (r) => emit(ForcastLoaded(r)));
  }

  Future<String> getCountry() async{
    Network n = new Network("http://ip-api.com/json");
    var locationSTR = (await n.getData());
    var locationx = jsonDecode(locationSTR);
    print(locationx);
    return locationx["city"];
  }
}
