import 'dart:convert';

import 'package:abac_challenge/config/config.dart';
import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/models/service_model.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DiagnoseRepo {
  Future<List<SpaceshipComponent>> searchComponent(String searchString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await http.get(
      Uri.parse(
          '${Config.baseUrl}/spaceship/search_pieces?search_string=$searchString'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var componentList = jsonDecode(response.body);
      var returnList = <SpaceshipComponent>[];
      for (var component in componentList) {
        returnList.add(SpaceshipComponent.fromJson(component));
      }
      return returnList;
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<AppointmentCell>> getAppointmentCells(
      DateTime startDate, DateTime endDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    startDate = startDate.subtract(Duration(
        hours: startDate.hour,
        minutes: startDate.minute,
        seconds: startDate.second,
        milliseconds: startDate.millisecond,
        microseconds: startDate.microsecond));
    endDate = endDate.subtract(Duration(
        hours: endDate.hour,
        minutes: endDate.minute,
        seconds: endDate.second,
        milliseconds: endDate.millisecond,
        microseconds: endDate.microsecond));

    var response = await http.get(
        Uri.parse(
            '${Config.baseUrl}/spaceship/get_appointments?start_date=$startDate&end_date=$endDate'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json-patch+json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      var appointmentList = jsonDecode(response.body);
      var returnList = <AppointmentCell>[];
      for (var appointment in appointmentList) {
        returnList.add(AppointmentCell.fromJson(appointment));
      }
      return returnList;
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  Future<String> addAppointment(AppointmentCell appointmentCell) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await http.post(
      Uri.parse('${Config.baseUrl}/spaceship/add_appointments'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(appointmentCell.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Appointment added successfully';
    } else {
      throw Exception('Failed to add appointment');
    }
  }

  Future<List<ServiceModel>> getServices(String searchString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // should be a paginate api call but to keep it simple i will get all the data
    // and sort it locally with 3 events
    var response = await http.get(
      Uri.parse(
          '${Config.baseUrl}/spaceship/get_services?search_string=$searchString'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var serviceList = jsonDecode(response.body);
      var returnList = <ServiceModel>[];
      for (var service in serviceList) {
        returnList.add(ServiceModel.fromJson(service));
      }
      return returnList;
    } else {
      throw Exception('Failed to load services');
    }
  }
}
