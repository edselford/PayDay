import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';

class Payslip {
  static Future<List<SalaryModel>> getSalary(BuildContext context) async {
    var res = await http.get(Uri.parse("$BASE_URL/salary/own_salary"),
        headers: {
          "Authorization": "Bearer $TOKEN"
        }).catchError((error) => http.Response(error.toString(), 400));

    if (!context.mounted) throw Exception("Context not mounted");
    if (res.statusCode == 401) {
      Auth.unauthorized(context);
      return [];
    }
    if (res.statusCode < 200 && res.statusCode >= 300) throw Exception("Error ${res.body}");

    List<dynamic> salaryList = jsonDecode(res.body);
    return salaryList.map((json) => SalaryModel.fromJson(json)).toList();
  }
}

class SalaryModel {
  final int basicSalary;
  final DateTime period;
  final int allowances;
  final int overtime;
  final int deductions;
  final int totalSalary;

  SalaryModel({
    required this.basicSalary,
    required this.period,
    required this.allowances,
    required this.overtime,
    required this.deductions,
    required this.totalSalary,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      basicSalary: json['basic_salary'],
      period: DateTime.parse(json['period']),
      allowances: json['allowances'],
      overtime: json['overtime'],
      deductions: json['deductions'],
      totalSalary: json['total_salary'],
    );
  }
}
