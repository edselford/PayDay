import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payday/pages/home.dart';
import 'package:payday/services/auth.dart';

class PayslipPage extends StatefulWidget {
  const PayslipPage({super.key});

  @override
  PayslipPageState createState() => PayslipPageState();
}

class PayslipPageState extends State<PayslipPage> {
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _allowancesController = TextEditingController();
  final TextEditingController _overtimeController = TextEditingController();
  final TextEditingController _deductionsController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  String? _genderController;
  String? _salarymethodController;
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
    _salaryController.dispose();
    _allowancesController.dispose();
    _overtimeController.dispose();
    _deductionsController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  Future<User?> validateUser(BuildContext context) async {
    try {
      return await Auth.me();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to validate user.'),
          ),
        );
      }
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _validateUserFuture = validateUser(context);
    _salaryController.text = '0';
    _allowancesController.text = '0';
    _overtimeController.text = '0';
    _deductionsController.text = '0';
    _totalController.text = '0';
  }

  void _updateTotalValue() {
    double salary = double.tryParse(_salaryController.text) ?? 0;
    double allowances = double.tryParse(_allowancesController.text) ?? 0;
    double overtime = double.tryParse(_overtimeController.text) ?? 0;
    double deductions = double.tryParse(_deductionsController.text) ?? 0;

    double total = salary + allowances + overtime - deductions;

    setState(() {
      _totalController.text = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    'Add Salary',
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
                          // Employee
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Employee',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                            offset: Offset(2, 2),
                                            blurRadius: 4)
                                      ],
                                      border: Border.all(
                                        color: Color(0xffD9D9D9),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 13, left: 13),
                                      child: DropdownButton(
                                        hint: Text(
                                          'Select',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        underline: SizedBox.shrink(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        value: _genderController,
                                        items:
                                            ['Edsel', 'Iqbal', 'Atha', 'etc'].map((val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(
                                              val,
                                              style: TextStyle(
                                                color: Color(0xff262626),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            _genderController = val;
                                          });
                                        },
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          // Periode
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Period Date',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: TextField(
                                        controller: _periodController,
                                        decoration: InputDecoration(
                                            labelText: "mm-yyyy",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            prefixIcon: Icon(
                                              Icons.calendar_today,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        readOnly: true,
                                        onTap: () {
                                          _selectDate();
                                        },
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Salary
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Salary',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: CupertinoTextField(
                                        controller: _salaryController,
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                            padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        onChanged: (value) {
                                          _updateTotalValue();
                                        },
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Allowances
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Allowances',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: CupertinoTextField(
                                        controller: _allowancesController,
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                            padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        onChanged: (value) {
                                          _updateTotalValue();
                                        },
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Overtime
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overtime',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: CupertinoTextField(
                                        controller: _overtimeController,
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                            padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        onChanged: (value) {
                                          _updateTotalValue();
                                        },
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Deductions
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deductions',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: CupertinoTextField(
                                        controller: _deductionsController,
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                            padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        onChanged: (value) {
                                          _updateTotalValue();
                                        },
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Total Salary
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Salary',
                                  style: TextStyle(
                                    color: Color(0xff262626),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                      padding: EdgeInsets.all(5),
                                      child: CupertinoTextField(
                                        controller: _totalController,
                                        keyboardType: TextInputType.number,
                                        prefix: Padding(
                                            padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        enabled: false,
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Submit
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 4,
                                  ),
                                  onPressed: null,
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xff3DC2EC),
                                          Color(0xff4B70F5),
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(2, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
