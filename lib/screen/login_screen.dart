import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config/app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future login() async {
    final response = await http.post(
      Uri.parse('$API_URL/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email.text,
        'password': _password.text,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('โปรดเข้าสู่ระบบ'),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'อีเมล',
              ),
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: 'รหัสผ่าน',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('เข้าสู่ระบบ'),
            )
          ],
        ),
      ),
    );
  }
}
