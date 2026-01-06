class WardrobeItem {
  WardrobeItem({
    required this.id,
    required this.category,
    required this.brand,
    required this.model,
    required this.quantity,
    this.price,
    this.notes,
  });

  final int id;
  final String category;
  final String brand;
  final String model;
  final int quantity;
  final double? price;
  final String? notes;
}

class WardrobeCategoryTotal {
  WardrobeCategoryTotal({
    required this.category,
    required this.totalValue,
    required this.totalItems,
  });

  final String category;
  final double totalValue;
  final int totalItems;
}
