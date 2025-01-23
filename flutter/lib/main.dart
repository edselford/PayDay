import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/attendance/attendance.dart';
import 'package:payday/pages/employee/employee.dart';
import 'package:payday/pages/payslip/payslip-list.dart';
import 'package:payday/pages/profile/edit_profile.dart';
import 'package:payday/pages/profile/profile.dart';
import 'package:payday/pages/salary/salary-list.dart';
import 'package:payday/pages/salary/salary.dart';
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
      theme: ThemeData.from(
              colorScheme: ColorScheme.light())
          .copyWith(textTheme: GoogleFonts.interTextTheme()),
      title: 'PayDay',
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: TOKEN == null ? '/auth' : '/home',
      routes: {
        '/auth': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),

        // Employee
        '/employee': (context) => const EmployeePage(),

        // Attendance
        '/attendance': (context) => AttendancePage(),

        // Pay Slip
        '/payslip/list': (context) => PayslipListPage(),

        // Salary
        '/salary': (context) => const SalaryPage(),
        '/salary/list': (context) => const SalaryListPage(),

        // Profile
        '/profile': (context) => ProfilePage(),
        '/profile/edit': (context) => EditProfilePage()
      },
    );
  }
}
