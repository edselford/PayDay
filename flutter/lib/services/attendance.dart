import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';

class AttendanceService {
  Future<Attendance?> status(BuildContext context) async {
    var res = await http.get(Uri.parse("$BASE_URL/attendance/status"),
        headers: {"Authorization": "Bearer $TOKEN"}).catchError((error) {
      return http.Response(error.toString(), 500);
    });

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var data = jsonDecode(res.body)['data'];
      return data == null ? null : Attendance.fromJson(data);
    } else if (res.statusCode == 401) {
      if (!context.mounted) throw Exception("Context not mounted");
      Auth.unauthorized(context);
    } else {
      print(res);
      throw Exception("Error ${res.statusCode}: Failed to load attendance");
    }
  }

  Future<bool?> check(BuildContext context) async {
    var res = await http.post(Uri.parse("$BASE_URL/attendance/check"),
        headers: {"Authorization": "Bearer $TOKEN"}).catchError((error) {
      return http.Response(error.toString(), 500);
    });

    if (!context.mounted) throw Exception("Context not mounted");

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // return Attendance.fromJson(jsonDecode(res.body));
      return true;
    } else if (res.statusCode == 401) {
      Auth.unauthorized(context);
    } else {
      throw Exception("Error ${res.statusCode}: Failed to load attendance");
    }
    return null;
  }
}

class Attendance {
  final int id;
  final int employeeId;
  final DateTime date;
  final DateTime inTime;
  final DateTime? leftTime;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.inTime,
    this.leftTime,
  });

  Duration getDuration() {
    final now = DateTime.now();
    return now.difference(inTime.add(Duration(hours: 6)));
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      employeeId: json['employee_id'],
      date: DateFormat("yyyy-MM-dd").parse(json['date']),
      inTime: DateFormat("HH:mm:ss").parse(json['in']),
      leftTime: json['left'] != null ? DateFormat("HH:mm:ss").parse(json['left']) : null,
    );
  }
}
