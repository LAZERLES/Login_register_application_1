import 'dart:convert';

import 'package:flutter_application_1/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Future<bool> checkLogin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_URL/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final prefs = await _prefs;
      prefs.setString('token', jsonDecode(response.body)['token']);
    }
  }
}
