import 'dart:math';

class ServiceModel {
  int serviceId;
  String name;
  String location;
  int cost;
  double rating;
  int reviews;
  double duration;
  String image;
  double distance = Random().nextDouble() * 10;

  ServiceModel({
    required this.serviceId,
    required this.name,
    required this.location,
    required this.cost,
    required this.image,
    required this.rating,
    required this.reviews,
    this.duration = 0,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['service_id'],
      name: json['name'],
      location: json['location'],
      cost: json['cost'],
      image: json['image'],
      rating: json['rating'],
      reviews: json['reviews'],
    );
  }
}
