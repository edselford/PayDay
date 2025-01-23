import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';
import 'package:payday/services/payslip.dart';

class PayslipListPage extends StatefulWidget {
  const PayslipListPage({super.key});

  @override
  PayslipListPageState createState() => PayslipListPageState();
}

class PayslipListPageState extends State<PayslipListPage> {
  final TextEditingController _periodController = TextEditingController();
  late Future<User?> _validateUserFuture;
  List<SalaryModel> payslips = [];

  @override
  void dispose() {
    _periodController.dispose();
    super.dispose();
  }

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

    Payslip.getSalary(context).then((val) => {
      setState(() {
        payslips = val;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: _validateUserFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       } else if (snapshot.hasData && snapshot.data != null) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pay Slip',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed('/home');
        //   },
        //   icon: Padding(
        //     padding: EdgeInsets.all(0),
        //     child: Icon(
        //       Icons.arrow_back,
        //       size: 30,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
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
          padding: EdgeInsets.only(right: 10, left: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...payslips.map(
                (pay) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/payslip',
                        arguments: pay,
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color(0xffF7F8F9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffEEF1F7))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatRupiah(pay.totalSalary),
                              style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(DateFormat("dd MMMM yyyy").format(pay.period))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, '/auth');
    //   });
    //   return const Scaffold(
    //     body: Center(
    //       child: Text('Redirecting...'),
    //     ),
    //   );
    // }
    // });
  }
}
