import 'package:abac_challenge/src/models/spaceship_component_model.dart';
import 'package:abac_challenge/src/models/service_model.dart';
import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';

class DiagnoseRepoMock implements DiagnoseRepo {
  @override
  Future<String> addAppointment(AppointmentCell appointmentCell) {
    appointments.add(appointmentCell);
    return Future.value('success');
  }

  @override
  Future<List<AppointmentCell>> getAppointmentCells(
      DateTime startDate, DateTime endDate) {
    var returnList = <AppointmentCell>[];
    for (var appointment in appointments) {
      if (appointment.date.isAfter(startDate) &&
          appointment.date.isBefore(endDate)) {
        returnList.add(appointment);
      }
    }
    return Future.value(returnList);
  }

  @override
  Future<List<ServiceModel>> getServices(String searchString) {
    var returnList = <ServiceModel>[];
    for (var service in services) {
      if (service.name.toLowerCase().contains(searchString.toLowerCase())) {
        returnList.add(service);
      }
    }
    return Future.value(returnList);
  }

  @override
  Future<List<SpaceshipComponent>> searchComponent(String searchString) {
    var returnList = <SpaceshipComponent>[];
    for (var component in components) {
      if (component.name.toLowerCase().contains(searchString.toLowerCase())) {
        returnList.add(component);
      }
    }
    return Future.value(returnList);
  }
}

var appointments = <AppointmentCell>[
  // make a AppointmentCell for each appointment in the list below
  // use the AppointmentCell.fromJson constructor

  AppointmentCell.fromJson({
    'appointment_id': 2,
    'date': '2023-05-12T14:58:54.149000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 3,
    'date': '2023-05-12T15:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 4,
    'date': '2023-05-12T11:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 5,
    'date': '2023-05-13T11:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 6,
    'date': '2023-05-13T12:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 7,
    'date': '2023-05-13T16:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 8,
    'date': '2023-05-15T11:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 9,
    'date': '2023-05-15T08:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 10,
    'date': '2023-05-15T09:00:00.818000',
    'user_id': 2
  }),
  AppointmentCell.fromJson({
    'appointment_id': 11,
    'date': '2023-05-16T15:00:00.818000',
    'user_id': 2
  }),
];

var services = <ServiceModel>[
  ServiceModel.fromJson({
    'service_id': 1,
    'name': 'Lorem Ipsum',
    'rating': 4.2,
    'reviews': 120,
    'location': 'Marte',
    'image': 'https://www.colorcombos.com/images/colors/42280E.png',
    'cost': 600
  }),
  ServiceModel.fromJson({
    'service_id': 2,
    'name': 'Lorem Lore',
    'rating': 5.0,
    'reviews': 812,
    'location': 'Jupiter',
    'image':
        'https://4.imimg.com/data4/TJ/JE/MY-12757033/choclate-brown-ht-food-colour-500x500.jpg',
    'cost': 800
  }),
  ServiceModel.fromJson({
    'service_id': 3,
    'name': 'Loremus LPS',
    'rating': 3.9,
    'reviews': 4,
    'location': 'Pluto',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmcNnl5ZEU2r-xn_CacUTGN3LmcYNABmw3zw&usqp=CAU',
    'cost': 400
  }),
  ServiceModel.fromJson({
    'service_id': 4,
    'name': 'LorIps Serv',
    'rating': 3.2,
    'reviews': 12,
    'location': 'Saturno',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmcNnl5ZEU2r-xn_CacUTGN3LmcYNABmw3zw&usqp=CAU',
    'cost': 200
  }),
  ServiceModel.fromJson({
    'service_id': 5,
    'name': 'LorIps Serv',
    'rating': 4.6,
    'reviews': 234,
    'location': 'Saturno',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmcNnl5ZEU2r-xn_CacUTGN3LmcYNABmw3zw&usqp=CAU',
    'cost': 200
  }),
  ServiceModel.fromJson({
    'service_id': 6,
    'name': 'LorIps Serv',
    'rating': 4.2,
    'reviews': 820,
    'location': 'Saturno',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmcNnl5ZEU2r-xn_CacUTGN3LmcYNABmw3zw&usqp=CAU',
    'cost': 200
  }),
];

var components = <SpaceshipComponent>[
  SpaceshipComponent.fromJson(
      {'piece_id': 1, 'name': 'Rulment', 'price': 1000}),
  SpaceshipComponent.fromJson(
      {'piece_id': 2, 'name': 'Planetara', 'price': 21000}),
  SpaceshipComponent.fromJson(
      {'piece_id': 3, 'name': 'Motor cu reactie', 'price': 110000}),
  SpaceshipComponent.fromJson({'piece_id': 4, 'name': 'Suruburi', 'price': 10}),
  SpaceshipComponent.fromJson({'piece_id': 5, 'name': 'Rulou', 'price': 1000}),
  SpaceshipComponent.fromJson({'piece_id': 6, 'name': 'Geam', 'price': 1200}),
  SpaceshipComponent.fromJson({'piece_id': 7, 'name': 'Usa', 'price': 900}),
  SpaceshipComponent.fromJson({'piece_id': 8, 'name': 'Scaun', 'price': 1200}),
  SpaceshipComponent.fromJson({'piece_id': 9, 'name': 'Volan', 'price': 1000}),
  SpaceshipComponent.fromJson({'piece_id': 10, 'name': 'Manere', 'price': 100}),
  SpaceshipComponent.fromJson({'piece_id': 11, 'name': 'Far', 'price': 1000}),
];
