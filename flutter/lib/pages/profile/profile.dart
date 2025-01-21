import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payday/services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    Auth.me().then((res) {
      setState(() {
        user = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff3DC2EC),
                  Color(0xff4B70F5),
                  Color(0xff4C3BCF)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/profile/edit");
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 85,
                    height: 85,
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
                          image:
                              AssetImage('assets/images/Untitleddesign51.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    user?.name ?? "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  SizedBox(height: 12),
                  Text(user?.role ?? "Loading...",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 65)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.email_outlined),
                    SizedBox(width: 10, height: 50),
                    Text(
                      user?.email ?? "Loading...",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 20),
                Text(
                  "Born Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.calendar_month),
                    SizedBox(width: 10, height: 50),
                    Text(
                      user == null
                          ? "Loading..."
                          : DateFormat("dd MMMM yyyy").format(user!.bornDate),
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 20),
                Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.people),
                    SizedBox(width: 10, height: 50),
                    Text(
                      user == null 
                      ? "Loading..."
                      : user!.gender == Gender.m ? "Male" : "Female",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
