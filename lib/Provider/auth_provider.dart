import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  File image;
  bool isPicAvail = false;
  String pickerError = '';

  double shopLatitude;
  double shopLongitude;
  String shopAddress;
  String placeName;
  String error = '';
  String email;

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFiled =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    if (pickedFiled != null) {
      this.image = File(pickedFiled.path);
      notifyListeners();
    } else {
      this.pickerError = 'ກະລຸນາເລືອກຮູບ';
      print('ກະລຸນາເລືອກຮູບ');
      notifyListeners();
    }
    return this.image;
  }

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;

    PermissionStatus _permissionGrandted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGrandted = await location.hasPermission();
    if (_permissionGrandted == PermissionStatus.denied) {
      _permissionGrandted = await location.requestPermission();
      if (_permissionGrandted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    this.shopLatitude = _locationData.latitude;
    this.shopLongitude = _locationData.longitude;
    notifyListeners();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var _address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var shopAddress = _address.first;
    this.shopAddress = shopAddress.addressLine;
    this.placeName = shopAddress.featureName;
    notifyListeners();
    return shopAddress;
  }

  // register vendor using email
  Future<UserCredential> registerVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'ລະຫັດບໍ່ປອດໄພ';
        notifyListeners();
        print('ລະຫັດບໍ່ປອດໄພ');
      } else if (e.code == 'email-already-in-use') {
        this.error = 'ອີແມລນີ້ຖືກໃຊ້ແລ້ວ';
        notifyListeners();
        print('ອີແມລນີ້ຖືກໃຊ້ແລ້ວ');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }

// login
  Future<UserCredential> loginVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'ລະຫັດບໍ່ປອດໄພ';
        notifyListeners();
        print('ລະຫັດບໍ່ປອດໄພ');
      } else if (e.code == 'email-already-in-use') {
        this.error = 'ອີແມລນີ້ຖືກໃຊ້ແລ້ວ';
        notifyListeners();
        print('ອີແມລນີ້ຖືກໃຊ້ແລ້ວ');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }

  // save vendor to db
  Future<void> saveVendorDataDb(
      {String url, String shopName, String mobile, String dialog}) {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _vendors =
        FirebaseFirestore.instance.collection('vendors').doc(user.uid);
    _vendors.set({
      'uid': user.uid,
      'shopName': shopName,
      'mobile': mobile,
      'email': this.email,
      'dialog': dialog,
      'address': '${this.placeName}:${this.shopAddress}',
      'location': GeoPoint(this.shopLatitude, this.shopLongitude),
      'shopOpen': true,
      'rating': 0.00,
      'totalRating': 0,
      'isTopPicked': true,
      'imageUrl': url,
      'accVerified': true // only verified vendor can sell product
    });
    return null;
  }
}
