import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/Screens/login_screen.dart';

import 'package:vendor/Screens/register_screen.dart';
import 'package:vendor/Screens/HoneScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginSreen.id);
        } else {
          Navigator.pushReplacementNamed(context, Home.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: [
              Lottie.asset('assets/customer.json', height: 300, width: 300),
              Hero(
                tag: 'Logo',
                child: Lottie.asset('assets/loading.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
