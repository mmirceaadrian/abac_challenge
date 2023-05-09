import 'dart:convert';

import 'package:abac_challenge/src/models/spaceship_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';

/// Repository for the spaceships
///
/// This repository is used to manage the data of the spaceships
class SpaceshipsRepo {
  /// This method is used to get the spaceships from the API
  Future<List<Spaceship>> getSpaceships() async {
    // should request just some spaceships, not all, in order to improve performance and avoid a lot of data
    // in order to do that, we should use a pagination system, and request from backend just a few spaceships per page
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var response = await http.get(
      Uri.parse('${Config.baseUrl}/spaceship/get'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var spaceshipList = jsonDecode(response.body);
      var returnList = <Spaceship>[];

      for (var spaceship in spaceshipList) {
        returnList.add(Spaceship.fromJson(spaceship));
      }
      return returnList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
