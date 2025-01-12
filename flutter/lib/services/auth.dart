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

  static void logout(BuildContext context) async {
    TOKEN = null;
    await storage.delete(key: 'token');
    if (context.mounted) Navigator.popAndPushNamed(context, '/auth');
  }

  static void login(BuildContext context, String email, String password) async {
    var res = await http.post(
      Uri.parse("$BASE_URL/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      TOKEN = jsonDecode(res.body);
      storage.write(key: 'token', value: TOKEN);
      if (context.mounted) Navigator.popAndPushNamed(context, '/home');
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${res.body}')),
        );
      }
    }
  }

  static Future<User> me() async {
    var res = await http.get(
      Uri.parse("$BASE_URL/me"),
      headers: {"Authorization": "Bearer $TOKEN"},
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
