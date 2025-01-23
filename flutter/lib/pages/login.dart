import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payday/components/custom-textfield.dart';
import 'package:payday/helper.dart';
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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      alert(context, "Username & password can't be empty");
      return;
    }
    Auth.login(context, _emailController.text, _passwordController.text);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Text(
  //           'PayDay',
  //           style: GoogleFonts.pacifico(
  //             fontSize: 60,
  //             foreground: Paint()..shader = LinearGradient(
  //               colors: <Color>[Color(0xff4B70F5), Color(0xff03C988)],
  //             ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 0.0))
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Expanded(
  //             child: DecoratedBox(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(20),
  //                   topRight: Radius.circular(20)),
  //               gradient: LinearGradient(
  //                   begin: Alignment.topCenter,
  //                   end: Alignment.bottomCenter,
  //                   colors: [
  //                     Color(0xff3DC2EC),
  //                     Color(0xff4B70F5),
  //                     Color(0xff4C3BCF),
  //                   ])),
  //           child: Padding(
  //             padding: EdgeInsets.all(20),
  //             child: Column(
  //               children: [
  //                 SizedBox(height: 20),
  //                 Text(
  //                   "LOGIN",
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.normal,
  //                       fontSize: 40),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(bottom: 10),
  //                     child: Text(
  //                       "Email",
  //                       textAlign: TextAlign.start,
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //                 CupertinoTextField(
  //                   controller: _emailController,
  //                   keyboardType: TextInputType.emailAddress,
  //                   prefix: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Icon(
  //                       CupertinoIcons.person,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(bottom: 10),
  //                     child: Text(
  //                       "Password",
  //                       textAlign: TextAlign.start,
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //                 CupertinoTextField(
  //                   controller: _passwordController,
  //                   obscureText: true,
  //                   prefix: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Icon(CupertinoIcons.lock),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 ElevatedButton(
  //                   onPressed: () => onLogin(),
  //                   child: const Text('LOGIN', style: TextStyle(color: Color(0xff4B70F5)),),
  //                 ),
  //                 Expanded(
  //                     child: Container(
  //                   alignment: Alignment.bottomCenter,
  //                   child: Text(
  //                     "Copyright PayDay 2025",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ))
  //               ],
  //             ),
  //           ),
  //         ))
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'PayDay',
                style: GoogleFonts.pacifico(
                    fontSize: 60,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[Color(0xff4B70F5), Color(0xff03C988)],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 0.0))),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              SizedBox(
                  width: 200,
                  child: Text(
                    "Payday adalah aplikasi pembayaran gaji karyawan yang berdiri sejak kemarin",
                    style: TextStyle(color: Colors.black.withAlpha(75)),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: _emailController,
                hint: "Masukkan email",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _passwordController,
                hint: "Masukkan password",
                isPassword: true,
              ),
              SizedBox(height: 129,),
              RawMaterialButton(
                onPressed: onLogin,
                child: Ink(
                  width: 346,
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
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
