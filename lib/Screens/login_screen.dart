import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Provider/auth_provider.dart';
import 'package:vendor/Screens/HoneScreen.dart';
import 'package:vendor/Screens/register_screen.dart';

class LoginSreen extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginSreenState createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {
  final _formKey = GlobalKey<FormState>();
  Icon icon;
  bool _visible = false;
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  String email, password;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ເຂົ້າສູ່ລະບົບ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Lottie.asset(
                          'assets/login.json',
                          height: 70,
                        )
                      ],
                    ),*/
                    Column(
                      children: [
                        Lottie.asset('assets/login.json',
                            height: 300, width: 300),
                        Text(
                          'ເຂົ້າສູ່ລະບົບ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາປ້ອນອີແມລ';
                        }
                        final bool _isValid = EmailValidator.validate(
                            _usernameTextController.text);
                        if (!_isValid) {
                          return 'ອີແມບໍ່ຖືກຕ້ອງ';
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'ບັນຊີຜູ້ໃຊ້',
                          prefixIcon: Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          focusColor: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ກະລຸນາໃສ່ລະຫັດຜ່ານ';
                        }
                        if (value.length < 6) {
                          return 'ລະຫັດຕ່ຳສຸດ 6 ຕົວອັກສອນ';
                        }
                        setState(() {
                          password = value;
                        });
                        return null;
                      },
                      obscureText: _visible == false ? true : false,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: _visible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'ລະຫັດຜ່ານ',
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          focusColor: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              _authData
                                  .loginVendor(email, password)
                                  .then((credential) {
                                if (credential != null) {
                                  setState(() {
                                    _loading = false;
                                  });
                                  Navigator.pushReplacementNamed(
                                      context, Home.id);
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(_authData.error)));
                                }
                              });
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          child: _loading
                              ? LinearProgressIndicator()
                              : Text(
                                  'ເຂົ້າລະບົບ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ))
                      ],
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: RichText(
                            text: TextSpan(text: '', children: [
                          TextSpan(
                              text: 'ຍັງບໍ່ມີບັນຊີ ? ',
                              style: TextStyle(color: Colors.black54)),
                          TextSpan(
                              text: 'ລົງທະບຽນ',
                              style: TextStyle(color: Colors.blue))
                        ])))
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
