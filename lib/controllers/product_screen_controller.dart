import 'dart:core';

import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  List<String> sizeTypes = ['UK', 'USA'];

  List<double> sizes = [7.5, 8.5, 9.5, 10.0];

  int selectedSizeType = 0;
  double selectedSize = 0.0;

  void selectSizeType(int index) {
    selectedSizeType = index;
    update(['sizeType']);
  }

  void selectSize(double size) {
    selectedSize = size;
    update(['size']);
  }
}
