/// Model for the Spaceship object
class Spaceship {
  final int spaceshipId;
  final String name;
  final String model;
  final int year;
  final String image;
  final int userId;

  Spaceship({
    required this.spaceshipId,
    required this.name,
    required this.model,
    required this.year,
    required this.image,
    required this.userId,
  });

  factory Spaceship.fromJson(Map<String, dynamic> json) {
    return Spaceship(
      spaceshipId: json['spaceship_id'],
      name: json['name'],
      model: json['model'],
      year: json['year'],
      image: json['image'],
      userId: json['user_id'],
    );
  }
}
