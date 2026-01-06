class StravaTokens {
  StravaTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.athleteId,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String? athleteId;

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  static DateTime? parseExpiresAt(String? value) {
    final seconds = int.tryParse(value ?? '');
    if (seconds == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}

class StravaActivity {
  StravaActivity({
    required this.id,
    required this.distanceMeters,
    required this.startDate,
    this.gearId,
  });

  final int id;
  final double distanceMeters;
  final DateTime startDate;
  final String? gearId;
}

class StravaBike {
  StravaBike({
    required this.gearId,
    required this.name,
    required this.distanceKm,
  });

  final String gearId;
  final String name;
  final int distanceKm;
}
