class Bike {
  Bike({
    required this.id,
    required this.name,
    required this.manualKm,
    required this.createdAt,
    this.purchasePrice,
    this.photoPath,
  });

  final int id;
  final String name;
  final double? purchasePrice;
  final String? photoPath;
  final int manualKm;
  final DateTime createdAt;
}

class BikeWithStats {
  BikeWithStats({
    required this.bike,
    required this.ridesKm,
  });

  final Bike bike;
  final int ridesKm;

  int get totalKm => bike.manualKm + ridesKm;
}
