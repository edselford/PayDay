import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payday/helper.dart';
import 'package:payday/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<User?> validateUser(BuildContext context) async {
    try {
      return await Auth.me();
    } catch (e) {
      if (context.mounted) alert(context, "Failed to validate user");
      return null;
    }
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
                leading: IconButton(
                    onPressed: () => {Auth.logout(context)},
                    icon: Icon(Icons.logout)),
                actions: [
                  IconButton(
                      onPressed: () => logout(context),
                      icon: Icon(Icons.settings_outlined))
                ],
              ),
              body: Column(children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff3DC2EC),
                                Color(0xff4B70F5),
                                Color(0xff4C3BCF)
                              ])),
                      child: Padding(
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
                    ),
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
