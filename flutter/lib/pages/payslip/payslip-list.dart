import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';

class PayslipListPage extends StatefulWidget {
  const PayslipListPage({super.key});

  @override
  PayslipListPageState createState() => PayslipListPageState();
}

class PayslipListPageState extends State<PayslipListPage> {
  final TextEditingController _periodController = TextEditingController();
  late Future<User?> _validateUserFuture;

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
                iconTheme: IconThemeData(
                  color: Colors.white
                ),
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
                        InkWell(
                          onTap: () {
                            print('object');
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
                                    right: 15,
                                    left: 15,
                                    top: 15,
                                    bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rp.1.000.000',
                                      style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Januari 2025',
                                      style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       'Rp.1.000.000',
                                    //       style: TextStyle(
                                    //           color: Color(0xff262626),
                                    //           fontSize: 16,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //     Text(
                                    //       'Januari 2025',
                                    //       style: TextStyle(
                                    //           color: Color(0xff262626),
                                    //           fontSize: 13,
                                    //           fontWeight: FontWeight.w500),
                                    //     )
                                    //   ],
                                    // ),
                                    // Icon(
                                    //   Icons.description_outlined,
                                    //   size: 25,
                                    //   color: Color(0xff262626),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
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
