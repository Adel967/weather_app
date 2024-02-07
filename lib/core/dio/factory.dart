import 'package:dio/dio.dart';


class DioFactory {
  static Dio create() {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/json'});
    final baseOptions = BaseOptions(
        headers: headers,
        responseType: ResponseType.plain,
        sendTimeout: const Duration(minutes: 2,),
        receiveTimeout: const Duration(minutes: 2,),
        connectTimeout: const Duration(milliseconds: 30000,));
    final dio = Dio(baseOptions);
    return dio;
  }
}
