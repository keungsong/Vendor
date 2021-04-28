import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider with ChangeNotifier {
  String selectedCategory = 'ຍັງບໍ່ໄດ້ເລືອກ';
  String selectedSubCategory = 'ຍັງບໍ່ໄດ້ເລືອກ';
  File image;
  String pickerError = '';
  selectCategory(selected) {
    this.selectedCategory = selected;
    notifyListeners();
  }

  selectSubCategory(selected) {
    this.selectedSubCategory = selected;
    notifyListeners();
  }

  Future<File> getProductImage() async {
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
}
