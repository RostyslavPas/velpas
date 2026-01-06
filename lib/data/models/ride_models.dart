class RideImport {
  RideImport({
    required this.id,
    required this.bikeId,
    required this.distanceKm,
    required this.dateTime,
    required this.source,
  });

  final String id;
  final int bikeId;
  final int distanceKm;
  final DateTime dateTime;
  final String source;
}

class RideImportInput {
  RideImportInput({
    required this.id,
    required this.bikeId,
    required this.distanceKm,
    required this.dateTime,
    required this.source,
  });

  final String id;
  final int bikeId;
  final int distanceKm;
  final DateTime dateTime;
  final String source;
}

class RideInsertResult {
  RideInsertResult({required this.added, required this.totalDistanceKm});

  final int added;
  final int totalDistanceKm;
}
