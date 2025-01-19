import 'package:flutter/material.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/employee/employee.dart';
import 'package:payday/services/auth.dart';
import 'pages/login.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Auth.runtimeToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayDay',
      debugShowCheckedModeBanner: false,
      initialRoute: TOKEN == null ? '/auth' : '/home',
      routes: {
        '/auth': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        
        // Employee
        '/employee': (context) => const EmployeePage()
      },
    );
  }
}
