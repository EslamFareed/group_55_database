import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_55_database/core/colors/app_color.dart';
import 'package:group_55_database/screens/home/home_screen.dart';
import 'package:group_55_database/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirebaseAuth.instance.currentUser == null
                ? LoginScreen()
                : HomeScreen(),
          ));
    });

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
