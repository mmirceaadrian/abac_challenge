import 'dart:convert';

import 'package:abac_challenge/config/config.dart';
import 'package:abac_challenge/src/models/appointment_cell.dart';
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
      DateTime startDate, DateTime endDate) {
    var list = <AppointmentCell>[];

    list.add(
      AppointmentCell(
        appointmentId: 1,
        date: DateTime(2023, 5, 12, 9, 0),
      ),
    );

    list.add(
      AppointmentCell(
        appointmentId: 2,
        date: DateTime(2023, 5, 15, 9, 0),
      ),
    );

    list.add(
      AppointmentCell(
        appointmentId: 3,
        date: DateTime(2023, 5, 12, 10, 0),
      ),
    );

    list.add(
      AppointmentCell(
        appointmentId: 4,
        date: DateTime(2023, 5, 11, 11, 0),
      ),
    );

    list.add(
      AppointmentCell(
        appointmentId: 5,
        date: DateTime(2023, 5, 11, 12, 0),
      ),
    );

    Future.delayed(Duration(seconds: 2));

    return Future.value(list);
  }
}
