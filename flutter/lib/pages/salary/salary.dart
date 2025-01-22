import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/home.dart';
import 'package:payday/services/auth.dart';
import 'package:payday/services/employee.dart';
import 'package:payday/services/salary.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  SalaryPageState createState() => SalaryPageState();
}

class SalaryPageState extends State<SalaryPage> {
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _allowancesController = TextEditingController();
  final TextEditingController _overtimeController = TextEditingController();
  final TextEditingController _deductionsController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  List<Map<String, dynamic>> employeeData = [];
  String? _employeeController;
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
      if (context.mounted) alert(context, "Failed to validate user");
      return null;
    }
  }

  Future getEmployee(BuildContext context) async {
    try {
      return await Employee.list();
    } catch (e) {
      if (context.mounted) alert(context, "Failed to validate user");
      return null;
    }
  }

  Future<void> generateEmployee() async {
    var emp_list = await getEmployee(context);

    List<dynamic> jsonData = jsonDecode(emp_list);

    setState(() {
      employeeData = List<Map<String, dynamic>>.from(jsonData);
    });
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

    // Employee List
    generateEmployee();
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
    final args = ModalRoute.of(context)?.settings.arguments;

    // Map<String, dynamic> data = args != null && args is Map<String, dynamic>
    //     ? Map<String, dynamic>.from(args)
    //     : {};
    if (args != null && args is Map<String, dynamic>) {
      Map<String, dynamic> data = Map<String, dynamic>.from(args);
      print(data);
      setState(() {
        _employeeController = data['employee']['user']['name'];
        _periodController.text = data['period'];
        _salaryController.text = data['basic_salary'].toString();
        _allowancesController.text = data['allowances'].toString();
        _overtimeController.text = data['overtime'].toString();
        _deductionsController.text = data['deductions'].toString();
        _totalController.text = data['total_salary'].toString();
      });
    }
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
                      Navigator.of(context).pushNamed('/salary/list');
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
                                        value: _employeeController,
                                        items: employeeData.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e['text'],
                                            child: Text(
                                              e['text'],
                                              style: TextStyle(
                                                color: Color(0xff262626),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _employeeController = value;

                                            final employee =
                                                employeeData.firstWhere(
                                              (e) => e['text'] == value,
                                              orElse: () => {"salary": 0},
                                            );

                                            _salaryController.text =
                                                employee['salary'].toString();

                                            _updateTotalValue();
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
                                  onPressed: () {
                                    if (_employeeController == null ||
                                        _employeeController == '') {
                                      alert(context, "Employee Required!");
                                    } else if (_periodController.text == '') {
                                      alert(context, "Period Required!");
                                    } else {
                                      Map<String, String?> data = {
                                        'employee': _employeeController,
                                        'period': _periodController.text,
                                        'salary': _salaryController.text,
                                        'allowances':
                                            _allowancesController.text,
                                        'overtime': _overtimeController.text,
                                        'deductions':
                                            _deductionsController.text,
                                        'total': _totalController.text,
                                      };
                                      Salary.store(context, data);
                                    }
                                  },
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
