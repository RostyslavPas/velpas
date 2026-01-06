import 'package:dio/dio.dart';

import '../models/strava_models.dart';

class StravaTokenService {
  StravaTokenService(this._dio);

  final Dio _dio;

  Future<StravaTokens> refresh(String refreshToken) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/strava/refresh/',
      data: {'refresh_token': refreshToken},
    );
    final data = response.data ?? {};
    return _mapTokens(data);
  }

  StravaTokens _mapTokens(Map<String, dynamic> data) {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expiresAt = data['expires_at'];
    if (accessToken is! String || refreshToken is! String || expiresAt is! num) {
      throw const FormatException('Invalid Strava token payload');
    }
    final athlete = data['athlete'];
    String? athleteId;
    if (athlete is Map && athlete['id'] != null) {
      athleteId = athlete['id'].toString();
    }
    return StravaTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(expiresAt.toInt() * 1000),
      athleteId: athleteId,
    );
  }
}
