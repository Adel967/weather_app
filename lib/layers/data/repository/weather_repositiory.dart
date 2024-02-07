import 'package:dartz/dartz.dart';
import 'package:weather/core/exceptions/app_exception.dart';
import 'package:weather/layers/data/data_provider/weather_provider.dart';
import 'package:weather/layers/data/model/forcast.dart';
import 'package:weather/layers/data/model/location.dart';

class WeatherRepository{

  final WeatherProvider weatherProvider = WeatherProvider();

  Future<Either<AppException,ForCast>> getForcast(String location) async{
    try{
      final res = await weatherProvider.getForcast(location);
      ForCast forCast = ForCast.fromJson(res);
      forCast.forCastDay.removeAt(0);
      return Right(forCast);
    }on AppException catch(e){
      return Left(e);
    }
  }

  Future<Either<AppException,List<Location>>> getLocation(String location) async{
    try{
      final res = await weatherProvider.getLocations(location);
      return Right(getListOfLocations(res));
    }on AppException catch(e){
      return Left(e);
    }
  }

}