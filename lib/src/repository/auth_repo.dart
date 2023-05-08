import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<String> attemptAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    final String? token = prefs.getString('token');
    if (token != null) {
      return token;
    } else {
      throw Exception('No token found');
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/user/login'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
      },
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', json.decode(response.body)['token']);
      return json.decode(response.body)['token'];
    } else if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/user/register'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
      },
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      throw Exception(json.decode(response.body)['detail']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
