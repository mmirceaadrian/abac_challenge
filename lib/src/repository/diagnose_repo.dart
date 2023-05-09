import 'dart:convert';

import 'package:abac_challenge/config/config.dart';
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
}
