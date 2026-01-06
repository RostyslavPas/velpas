import 'package:dio/dio.dart';

class StravaApiClient {
  StravaApiClient(this._dio);

  final Dio _dio;

  Future<void> ping() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
