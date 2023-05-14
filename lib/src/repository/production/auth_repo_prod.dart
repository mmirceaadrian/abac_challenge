import 'dart:convert';

import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/config.dart';
import 'package:http/http.dart' as http;

/// Repository for the auth screen
///
/// This repository is used to manage the authentication data from backend
class AuthRepoProd extends AuthRepo {
  /// This method is used to attempt the auto login
  @override
  Future<String> attemptAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('token'); // uncomment this line to test the auto login
    final String? token = prefs.getString('token');
    if (token != null) {
      return token;
    } else {
      throw Exception('No token found');
    }
  }

  /// This method is used to login
  @override
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

  /// This method is used to register
  @override
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

  @override
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
