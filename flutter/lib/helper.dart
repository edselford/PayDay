import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String BASE_URL = defaultTargetPlatform == TargetPlatform.android
    ? "http://10.0.2.2:8000/api"
    : "http://localhost:8000/api";
String? TOKEN;


void alert(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}