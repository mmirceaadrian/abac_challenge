class Service {
  int serviceId;
  String name;
  String location;
  int cost;
  String image;

  Service({
    required this.serviceId,
    required this.name,
    required this.location,
    required this.cost,
    required this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'],
      name: json['name'],
      location: json['location'],
      cost: json['cost'],
      image: json['image'],
    );
  }
}
