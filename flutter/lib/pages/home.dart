import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<bool> validateUser() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isValid = true;
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: validateUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: const Center(
              child: Text(
                'Welcome back, User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/');
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
