import 'dart:io';

String BASE_URL = Platform.isAndroid
    ? "http://10.0.2.2:8000/api"
    : "http://localhost:8000/api";
String? TOKEN;
