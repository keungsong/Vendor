import 'package:flutter/material.dart';
import 'package:vendor/Screens/dasboard_screen.dart';
import 'package:vendor/Screens/product_screen.dart';

class DrawerServices {
  Widget drawerScreen(title) {
    if (title == 'ແຜນຄວບຄຸມ') {
      return MainScreen();
    }
    if (title == 'ສີນຄ້າ') {
      return ProductScreen();
    }
    return MainScreen();
  }
}
