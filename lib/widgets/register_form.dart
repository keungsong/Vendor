import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Provider/auth_provider.dart';
import 'package:vendor/Screens/HoneScreen.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _confiremPasswordTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _nameTextController = TextEditingController();
  var _dialogTextController = TextEditingController();
  String email, password, mobile, shopName;
  bool _isLoading = false;

  Future<String> uploadFile(String filePath) async {
    File file = File(filePath);

    FirebaseStorage _storage = FirebaseStorage.instance;

    try {
      await _storage
          .ref('ShopProfile/${_nameTextController.text}')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
    // now after upload file
    String downloadURl = await _storage
        .ref('ShopProfile/${_nameTextController.text}')
        .getDownloadURL();
    return downloadURl;
  }

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);

    Scaffoldmessage(message) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return _isLoading
        ? CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          )
        : Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return '?????????????????????????????????????????????????????????';
                      }
                      setState(() {
                        _nameTextController.text = value;
                      });
                      shopName = value;
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.store_mall_directory),
                        labelText: '??????????????????????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 8, // depends on the country where u use the app
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '?????????????????????????????????????????????????????????';
                      }
                      setState(() {
                        mobile = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        prefixText: '+856020',
                        labelText: '??????????????????????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '??????????????????????????????????????????';
                      }
                      final bool _isValid =
                          EmailValidator.validate(_emailTextController.text);
                      if (!_isValid) {
                        return '??????????????????????????????????????????';
                      }
                      setState(() {
                        email = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline),
                        labelText: '???????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '??????????????????????????????????????????????????????';
                      }
                      if (value.length < 6) {
                        return '????????????????????????????????? 6 ???????????????????????????';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        labelText: '???????????????????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '???????????????????????????????????????????????????????????????????????????';
                      }
                      if (_passwordTextController.text !=
                          _confiremPasswordTextController.text) {
                        return '?????????????????????????????????????????????????????? ????????????????????????????????????????????????';
                      }
                      setState(() {
                        password = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        labelText: '?????????????????????????????????????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 6,
                    controller: _addressTextController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '???????????????????????????????????????????????????????????????';
                      }
                      if (_authData.shopLatitude == null) {
                        return '???????????????????????????????????????????????????????????????';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map_outlined),
                        labelText: '?????????????????????????????????????????????',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.location_searching),
                          onPressed: () {
                            _addressTextController.text = ' ?????????????????????????????????...';
                            _authData.getCurrentAddress().then((address) {
                              if (address != null) {
                                setState(() {
                                  _addressTextController.text =
                                      '${_authData.placeName}\n${_authData.shopAddress}';
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        '??????????????????????????????????????????????????????????????????...????????????????????????????????????')));
                              }
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      _dialogTextController.text = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.comment),
                        labelText: '????????????????????????????????????',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        focusColor: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_authData.isPicAvail == true) {
                              // first will validate profile picture
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                // then will validte forms
                                _authData
                                    .registerVendor(email, password)
                                    .then((credential) => {
                                          if (credential.user.uid != null)
                                            {
                                              // user register
                                              uploadFile(_authData.image.path)
                                                  .then((url) {
                                                if (url != null) {
                                                  // save vendor details to db
                                                  _authData.saveVendorDataDb(
                                                    url: url,
                                                    mobile: mobile,
                                                    shopName: shopName,
                                                    dialog:
                                                        _dialogTextController
                                                            .text,
                                                  );

                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, Home.id);
                                                } else {
                                                  Scaffoldmessage(
                                                      '???????????????????????????????????????');
                                                }
                                              })
                                            }
                                          else
                                            {
                                              // register failed
                                              Scaffoldmessage(_authData.error),
                                            }
                                        });
                              }
                            } else {
                              Scaffoldmessage('???????????????????????????????????????????????????????????????...');
                            }
                          },
                          child: Text(
                            '????????????????????????',
                            style: TextStyle(color: Colors.white),
                          )),
                    ))
                  ],
                )
              ],
            ));
  }
}
