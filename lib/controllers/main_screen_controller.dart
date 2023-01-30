import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/sneaker_model.dart';

class MainScreenController extends GetxController {
  List<String> brands = ['Nike', 'Adidas', 'Jordan', 'Puma', 'Reebok'];

  List<String> category = ['New', 'Featured', 'Upcoming'];

  List<SneakerModel> sneakers = [
    SneakerModel(
        maker: 'Nike',
        model: 'Air-300',
        image: 'assets/sneaker_01.png',
        price: 129.00),
    SneakerModel(
        maker: 'Nike',
        model: 'Power-240',
        image: 'assets/sneaker_02.png',
        price: 199.99),
    SneakerModel(
        maker: 'Nike',
        model: 'Master-100',
        image: 'assets/sneaker_03.png',
        price: 149.39),
    SneakerModel(
        maker: 'Nike',
        model: 'OG-099',
        image: 'assets/sneaker_04.png',
        price: 189.09),
  ];

  final pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );

  int navigationBarIndex = 0;
  int selectedBrandIndex = 0;
  int selectedCategoryIndex = 1;

  void changeNavigationBarIndex(int index) {
    navigationBarIndex = index;
    update(['navigationBar']);
  }

  void changeBrand(int index) {
    selectedBrandIndex = index;
    update(['brandsList']);
  }

  void changeCategory(int index) {
    selectedCategoryIndex = index;
    update(['categoriesList']);
  }
}
