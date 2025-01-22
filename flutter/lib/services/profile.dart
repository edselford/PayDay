import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';

class ProfileService {
  static Future<void> changeProfile(
      String name, Gender gender, String bornDate, Function callback) async {
    var res = await http.post(
      Uri.parse("$BASE_URL/edit_profile"),
      headers: {
        "Authorization": "Bearer $TOKEN",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": name,
        "gender": gender.toString().split('.').last,
        "born_date": bornDate
      }),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      callback();
    } else {
      throw Exception("Failed to edit profile, ${res.body}");
    }
  }
}
