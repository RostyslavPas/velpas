class ComponentItem {
  ComponentItem({
    required this.id,
    required this.bikeId,
    required this.type,
    required this.brand,
    required this.model,
    required this.expectedLifeKm,
    required this.installedAtBikeKm,
    required this.isActive,
    this.price,
    this.notes,
  });

  final int id;
  final int bikeId;
  final String type;
  final String brand;
  final String model;
  final int expectedLifeKm;
  final int installedAtBikeKm;
  final double? price;
  final String? notes;
  final bool isActive;
}

class ComponentHistoryItem {
  ComponentHistoryItem({
    required this.id,
    required this.componentId,
    required this.bikeId,
    required this.removedAtBikeKm,
    required this.removedAt,
    this.price,
    this.notes,
    this.componentBrand,
    this.componentModel,
  });

  final int id;
  final int componentId;
  final int bikeId;
  final int removedAtBikeKm;
  final DateTime removedAt;
  final double? price;
  final String? notes;
  final String? componentBrand;
  final String? componentModel;
}

class ComponentWearSnapshot {
  ComponentWearSnapshot({
    required this.component,
    required this.bikeName,
    required this.bikeKm,
  });

  final ComponentItem component;
  final String bikeName;
  final int bikeKm;
}
