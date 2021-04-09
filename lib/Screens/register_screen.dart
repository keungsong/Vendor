import 'package:flutter/material.dart';
import 'package:vendor/widgets/image_picker.dart';
import 'package:vendor/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'register-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [ShopPicCard(), RegisterForm()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
