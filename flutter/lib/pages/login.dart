import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payday/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLogin() {
    Auth.login(context, _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'PayDay',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = LinearGradient(
                colors: <Color>[Color(0xff4B70F5), Color(0xff03C988)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 0.0))
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3DC2EC),
                      Color(0xff4B70F5),
                      Color(0xff4C3BCF),
                    ])),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Password",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    controller: _passwordController,
                    obscureText: true,
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => onLogin(),
                    child: const Text('LOGIN', style: TextStyle(color: Color(0xff4B70F5)),),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Copyright PayDay 2025",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
