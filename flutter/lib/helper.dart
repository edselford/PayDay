import 'package:flutter/foundation.dart';

String BASE_URL = defaultTargetPlatform == TargetPlatform.android
    ? "http://10.0.2.2:8000/api"
    : "http://localhost:8000/api";
String? TOKEN;
