import 'dart:math';

import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoMock implements AuthRepo {
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

  @override
  Future<String> login(String email, String password) {
    final user = users.firstWhere((element) => element['email'] == email);
    if (user['password'] == password) {
      final token = Random().nextInt(100000).toString();
      return Future.value(token);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<Map<String, dynamic>> register(String email, String password) {
    final user = users.firstWhere((element) => element['email'] == email,
        orElse: () => {});
    if (user.isEmpty) {
      users.add({"email": email, "password": password});
      return Future.value({"email": email, "password": password});
    } else {
      throw Exception('Email already exists');
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}

var users = [
  {
    "id": 0,
    "email": "test@gmail.com",
    "password": "test12",
  }
];
