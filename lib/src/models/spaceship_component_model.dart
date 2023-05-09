class SpaceshipComponent {
  int spaceshipComponentId;
  String name;
  int price;
  int quantity;
  int get quantityPrice => price * quantity;

  SpaceshipComponent({
    required this.spaceshipComponentId,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  factory SpaceshipComponent.fromJson(Map<String, dynamic> json) {
    return SpaceshipComponent(
      spaceshipComponentId: json['piece_id'],
      name: json['name'],
      price: json['price'],
    );
  }

  SpaceshipComponent copyWith({
    int? spaceshipComponentId,
    String? name,
    int? price,
    int? quantity,
  }) {
    return SpaceshipComponent(
      spaceshipComponentId: spaceshipComponentId ?? this.spaceshipComponentId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
