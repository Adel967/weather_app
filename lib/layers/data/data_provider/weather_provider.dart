import 'package:weather/core/data/api_endpoints.dart';
import 'package:weather/core/data/data_provider.dart';
import 'package:weather/layers/data/model/forcast.dart';

class WeatherProvider extends RemoteDataSource{


  Future<dynamic> getForcast(String location) async{
    var urlParams = {
      "q": location,
      "days": "8"
    };
    final res = await get(EndPoints.FORCAST_ENDPOINT, urlParams);
    return Future.value(res);
  }
  
  Future<dynamic> getLocations(String text) async{
    var urlParams = {
      "q": text
    };
    final res = await get(EndPoints.SEARCH_ENDPOINT, urlParams);
    return Future.value(res);
  }
}