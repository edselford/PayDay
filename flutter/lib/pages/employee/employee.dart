import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payday/helper.dart';
import 'package:payday/pages/home.dart';
import 'package:payday/services/auth.dart';
import 'package:payday/services/employee.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  EmployeePageState createState() => EmployeePageState();
}

class EmployeePageState extends State<EmployeePage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _joindateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  String? _genderController;
  String? _salarymethodController;
  late Future<User?> _validateUserFuture;

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _joindateController.dispose();
    _salaryController.dispose();
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
                    'Add Employee',
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
                          // Fullname
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fullname',
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
                                        controller: _fullnameController,
                                        keyboardType: TextInputType.text,
                                        prefix:
                                            Padding(padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Email
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
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
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        prefix:
                                            Padding(padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Password
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
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
                                        controller: _passwordController,
                                        keyboardType: TextInputType.text,
                                        prefix:
                                            Padding(padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Gender
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
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
                                      padding:
                                          EdgeInsets.only(right: 13, left: 13),
                                      child: DropdownButton(
                                        hint: Text(
                                          'Select',
                                          style: TextStyle(
                                            fontSize: 17
                                          ),
                                        ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        underline: SizedBox.shrink(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        value: _genderController,
                                        items: ['Lelaki', 'Perempuan'].map((val) {
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
                          // Joining Date
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Joining Date',
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
                                        controller: _joindateController,
                                        decoration: InputDecoration(
                                          labelText: "yyyy-mm-dd",
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none
                                          )
                                        ),
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
                                        keyboardType: TextInputType.text,
                                        prefix:
                                            Padding(padding: EdgeInsets.all(.8)),
                                        decoration: BoxDecoration(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                      )),
                                )
                              ],
                            ),
                          ),
                          // Salary Method
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Salary Method',
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
                                      padding:
                                          EdgeInsets.only(right: 13, left: 13),
                                      child: DropdownButton(
                                        hint: Text(
                                          'Select',
                                          style: TextStyle(
                                            fontSize: 17
                                          ),
                                        ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        underline: SizedBox.shrink(),
                                        style:
                                            TextStyle(color: Color(0xff262626)),
                                        value: _salarymethodController,
                                        items: ['Per Jam', 'Per Hari', 'Per Bulan'].map((val) {
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
                                            _salarymethodController = val;
                                          });
                                        },
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          // Submit
                          Padding(
                            padding: EdgeInsets.only(top: 20),
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
                                    print(Employee.list());
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
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
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
                          SizedBox(height: 20,)
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
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _joindateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
