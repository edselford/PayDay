import 'package:flutter/material.dart';
import 'package:payday/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<User?> validateUser(BuildContext context) async {
    try {
      return await Auth.me();
    } catch(e) {
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
              title: const Text('Home'),
            ),
            body: Center(
              child: Text(
                'Welcome back, ${snapshot.data?.name}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
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
