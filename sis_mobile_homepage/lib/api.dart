import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'assessment_sessions.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> getToken(String username, String password) async {
  final url = Uri.parse('http://localhost:8000/api/-token/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'username': username, 'password': password}),
  );
  if (response.statusCode == 200) {
    String token = json.decode(response.body)['token'];
    await storage.write(key: 'token', value: token);
  } else {
    throw Exception('Failed to get token.');
  }
}