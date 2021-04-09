import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/Screens/login_screen.dart';
import 'package:vendor/Screens/register_screen.dart';

class Home extends StatefulWidget {
  static const String id = 'home-screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginSreen.id);
              })
        ],
      ),
    );
  }
}
