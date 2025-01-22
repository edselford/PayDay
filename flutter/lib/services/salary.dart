import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payday/helper.dart';

class Salary {
  static FlutterSecureStorage storage = FlutterSecureStorage();

  static void store(BuildContext context, Map<String, String?> data) async {
    var token = await storage.read(key: 'token');

    var res = await http.post(
      Uri.parse("$BASE_URL/salary/store"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (context.mounted) Navigator.popAndPushNamed(context, '/salary/list');
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Store failed: ${res.body}')),
        );
      }
    }
  }

  static list() async {
    var res = await http.get(
      Uri.parse("$BASE_URL/salary/list"),
      headers: {"Authorization": "Bearer $TOKEN"},
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res.body;
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
