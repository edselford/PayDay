import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<User?> validateUser(BuildContext context) async {
    return await Auth.me()
    .catchError((error) {
      if (context.mounted) {
        alert(context, error.toString());
        return null;
      }
    });
  }

  void logout(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 80, 0, 0),
      items: [
        PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
    ).then((value) {
      if (value == 'logout') {
        if (context.mounted) Auth.logout(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: validateUser(context),
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
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: IconButton(
                    onPressed: () => {Auth.logout(context)},
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 10),
                    child: IconButton(
                      onPressed: () => logout(context),
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              body: Column(children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 103,
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/profile");
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff3DC2EC),
                                  Color(0xff4B70F5),
                                  Color(0xff4C3BCF)
                                ]),
                          ),
                          child: Stack(children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    snapshot.data!.role,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(118),
                                        topRight: Radius.circular(118),
                                        bottomLeft: Radius.circular(118),
                                        bottomRight: Radius.circular(118),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.25),
                                            offset: Offset(0, 4),
                                            blurRadius: 4)
                                      ],
                                      border: Border.all(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Untitleddesign51.png'),
                                          fit: BoxFit.fitWidth),
                                    )),
                              ),
                            )
                          ]),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: SizedBox(
                                width: double.infinity,
                                height: 103,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/payslip/list');
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xff3DC2EC),
                                            Color(0xff4B70F5),
                                          ]),
                                    ),
                                    child: Stack(children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.receipt_long_outlined,
                                                size: 75,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Pay Slip',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: SizedBox(
                                width: double.infinity,
                                height: 103,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/attendance');
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xff3DC2EC),
                                            Color(0xff4B70F5),
                                          ]),
                                    ),
                                    child: Stack(children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                size: 75,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Attendance',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 40),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/employee');
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 72,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: SizedBox(
                                      width: 14,
                                      height: 72,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            bottomLeft: Radius.circular(7),
                                          ),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xff3DC2EC),
                                                Color(0xff4B70F5),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      size: 35,
                                      color: Color(0xff262626),
                                    ),
                                  ),
                                  Text(
                                    'Employee',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/salary/list');
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 72,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: SizedBox(
                                      width: 14,
                                      height: 72,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            bottomLeft: Radius.circular(7),
                                          ),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xff3DC2EC),
                                                Color(0xff4B70F5),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.attach_money_rounded,
                                      size: 35,
                                      color: Color(0xff262626),
                                    ),
                                  ),
                                  Text(
                                    'Salary',
                                    style: TextStyle(
                                      color: Color(0xff262626),
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ]));
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
      },
    );
  }
}

// Positioned(
                          //     top: 29,
                          //     left: 22,
                          //     child: Text(
                          //       'Athadzaki Sinaga, Phd.',
                          //       textAlign: TextAlign.left,
                          //       style: TextStyle(
                          //           color: Color.fromRGBO(255, 255, 255, 1),
                          //           fontFamily: 'NTR',
                          //           fontSize: 20,
                          //           letterSpacing:
                          //               0 /*percentages not used in flutter. defaulting to zero*/,
                          //           fontWeight: FontWeight.normal,
                          //           height: 1),
                          //     )),
                          // Positioned(
                          //     top: 55,
                          //     left: 22,
                          //     child: Text(
                          //       'HRD',
                          //       textAlign: TextAlign.left,
                          //       style: TextStyle(
                          //           color: Color.fromRGBO(255, 255, 255, 1),
                          //           fontFamily: 'NTR',
                          //           fontSize: 14,
                          //           letterSpacing:
                          //               0 /*percentages not used in flutter. defaulting to zero*/,
                          //           fontWeight: FontWeight.normal,
                          //           height: 1),
                          //     )),
                          // Positioned(
                          //     top: 19,
                          //     left: 285,
                          //     child: Container(
                          //         width: 64.0495834350586,
                          //         height: 64,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.only(
                          //             topLeft: Radius.circular(118),
                          //             topRight: Radius.circular(118),
                          //             bottomLeft: Radius.circular(118),
                          //             bottomRight: Radius.circular(118),
                          //           ),
                          //           boxShadow: [
                          //             BoxShadow(
                          //                 color: Color.fromRGBO(0, 0, 0, 0.25),
                          //                 offset: Offset(0, 4),
                          //                 blurRadius: 4)
                          //           ],
                          //           border: Border.all(
                          //             color: Color.fromRGBO(255, 255, 255, 1),
                          //             width: 2,
                          //           ),
                          //           image: DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/Untitleddesign51.png'),
                          //               fit: BoxFit.fitWidth),
                          //         ))),