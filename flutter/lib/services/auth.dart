import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payday/helper.dart';

class Auth {
  static FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> runtimeToken() async {
    TOKEN = await storage.read(key: 'token');
  }

  static void unauthorized(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Session Expired')),
    );
    logout(context);
  }

  static void logout(BuildContext context) async {
    TOKEN = null;
    await storage.delete(key: 'token');
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
    }
  }

  static void login(BuildContext context, String email, String password) async {
    var res = await http
        .post(
      Uri.parse("$BASE_URL/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    )
        .catchError((error) {
          print(error);
      return http.Response(error.toString(), 500);
    });

    if (!context.mounted) throw Exception("Context not mounted");
    if (res.statusCode >= 200 && res.statusCode < 300) {
      TOKEN = jsonDecode(res.body);
      storage.write(key: 'token', value: TOKEN);
      Navigator.popAndPushNamed(context, '/home');
    } else if (res.statusCode == 401) {
      alert(context, "Username or Password Incorrect");
    } else {
      alert(context, "Error ${res.body}");
    }
  }

  static Future<User> me() async {
    var res = await http.get(
      Uri.parse("$BASE_URL/me"),
      headers: {"Authorization": "Bearer $TOKEN"},
    ).catchError((error) {
      return http.Response(error.toString(), 500);
    });

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return User.fromJson(jsonDecode(res.body));
    } else {
          print(res.body);
      throw Exception('Failed to load user data, ${res.body}');
    }
  }
}

enum Gender { m, f }

class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String age;
  final Gender gender;
  final DateTime bornDate;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      required this.age,
      required this.gender,
      required this.bornDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role']['name'],
        age: json['age'],
        gender: Gender.values
            .firstWhere((e) => e.toString() == 'Gender.' + json['gender']),
        bornDate: DateTime.parse(json['born_date']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'age': age,
      'gender': gender.toString().split('.').last,
      'bornDate': bornDate.toIso8601String(),
    };
  }
}
