import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/home.dart';
import 'package:payday/services/auth.dart';
import 'package:payday/services/payslip.dart';

class PayslipPage extends StatefulWidget {
  const PayslipPage({super.key});

  @override
  PayslipPageState createState() => PayslipPageState();
}

class PayslipPageState extends State<PayslipPage> {
  late Future<User?> _validateUserFuture;

  Future<User?> validateUser(BuildContext context) async {
    try {
      return await Auth.me();
    } catch (e) {
      if (context.mounted) alert(context, "Failed to validate user");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _validateUserFuture = validateUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final SalaryModel salary =
        ModalRoute.of(context)?.settings.arguments as SalaryModel;

    return FutureBuilder(
        future: _validateUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Payslip',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  // elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff3DC2EC), // Warna awal gradasi
                          Color(0xff4B70F5), // Warna akhir gradasi
                          Color(0xff4C3BCF), // Warna akhir gradasi
                        ],
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(right: 20, left: 20, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Basic Salary"),
                              Text(formatRupiah(salary.basicSalary))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Allowances"),
                              Text(formatRupiah(salary.allowances))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Overtime"),
                              Text(formatRupiah(salary.overtime))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Deductions"),
                              Text("-${formatRupiah(salary.deductions)}")
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Salary"),
                              Text(formatRupiah(salary.totalSalary))
                            ],
                          )
                        ],
                      )),
                ));
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/auth');
            });
            return const Scaffold(
              body: Center(
                child: Text('Redirecting...'),
              ),
            );
          }
        });
  }
}
