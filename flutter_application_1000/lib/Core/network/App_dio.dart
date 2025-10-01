import 'package:dio/dio.dart';

class AppDio {
  Dio _dio;
  Dio get dio => _dio;

  AppDio(this._dio) {
    _dio.options.headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYxMTE4NjMzLCJpYXQiOjE3NTg1MjY2MzMsImp0aSI6ImM1MGM4NTAyMWM1MDRmYzdiY2JjYmIyMTJkOWQ3NjRiIiwidXNlcl9pZCI6IjIifQ.MUGK14YXsoxMUgEX83kSaaSoijjNfrcynoGM4s66e9k',
      'Content-Type': 'multipart/form-data',
    };
  }

  addToken(String token) {
    dio.options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}
