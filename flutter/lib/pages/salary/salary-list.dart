import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/home.dart';
import 'package:payday/services/auth.dart';
import 'package:payday/services/employee.dart';
import 'package:payday/services/salary.dart';

class SalaryListPage extends StatefulWidget {
  const SalaryListPage({super.key});

  @override
  SalaryListPageState createState() => SalaryListPageState();
}

class SalaryListPageState extends State<SalaryListPage> {
  final TextEditingController _periodController = TextEditingController();
  List<Map<String, dynamic>> employeeData = [];
  late Future<User?> _validateUserFuture;

  List<String> monthList = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

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

  Future getSalary(BuildContext context) async {
    try {
      return await Salary.list();
    } catch (e) {
      if (context.mounted) alert(context, "Failed to validate user");
      return null;
    }
  }

  Future<void> generateSalary() async {
    var emp_list = await getSalary(context);

    List<dynamic> jsonData = jsonDecode(emp_list);

    setState(() {
      employeeData = List<Map<String, dynamic>>.from(jsonData);
    });
  }

  String formatNumber(String number) {
    if (number.isEmpty || int.tryParse(number) == null) {
      return '';
    }

    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(int.parse(number)).replaceAll(',', '.');
  }


  @override
  void initState() {
    super.initState();
    _validateUserFuture = validateUser(context);
    generateSalary();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Item 1', 'Item 2', 'Item 3'];
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
                  'Salary',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
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
                    padding: EdgeInsets.only(right: 10, left: 10, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 35),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(6)),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             color: Color.fromRGBO(0, 0, 0, 0.25),
                        //             offset: Offset(2, 2),
                        //             blurRadius: 4)
                        //       ],
                        //       border: Border.all(
                        //         color: Color(0xffD9D9D9),
                        //         width: 1,
                        //       ),
                        //     ),
                        //     child: Padding(
                        //         padding: EdgeInsets.all(0),
                        //         child: TextField(
                        //           controller: _periodController,
                        //           decoration: InputDecoration(
                        //               labelText: "Select Period",
                        //               floatingLabelBehavior:
                        //                   FloatingLabelBehavior.never,
                        //               prefixIcon: Icon(
                        //                 Icons.calendar_today,
                        //               ),
                        //               enabledBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide.none),
                        //               focusedBorder: OutlineInputBorder(
                        //                   borderSide: BorderSide.none)),
                        //           style: TextStyle(color: Color(0xff262626)),
                        //           readOnly: true,
                        //           onTap: () {
                        //             _selectDate();
                        //           },
                        //         )),
                        //   ),
                        // ),
                        ...employeeData.map((e) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/salary',
                                  arguments: e['data'],
                                );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(2, 2),
                                          blurRadius: 4)
                                    ],
                                    border: Border.all(
                                      color: Color(0xffD9D9D9),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 15, left: 15, top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e['text'],
                                              style: TextStyle(
                                                  color: Color(0xff262626),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Rp.${formatNumber(e['salary'].toString())} - ${e['period']}',
                                              style: TextStyle(
                                                  color: Color(0xff262626),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.edit_outlined,
                                          size: 25,
                                          color: Color(0xff262626),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      ],
                    )),
              ),
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff3DC2EC),
                        Color(0xff4B70F5),
                      ]),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/salary');
                  },
                  tooltip: 'Add New',
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            );
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _periodController.text =
            "${monthList[_picked.month - 1]}, ${_picked.year}";
      });
    }
  }
}
