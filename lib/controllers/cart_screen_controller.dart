import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/sneaker_model.dart';

class CartScreenController extends GetxController {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<SneakerModel> toBeAdded = [];

  List<SneakerModel> currentSneakers = [];

  int totalItems = 0;
  double totalPrice = 0.00;

  void increaseItems() {
    totalItems++;
  }

  void decreaseItems() {
    totalItems--;
  }

  void updatePrice() {
    totalPrice = 0.00;
    for (var element in currentSneakers) {
      totalPrice = totalPrice + element.price;
    }
  }

  void addToCart(SneakerModel sneaker) {
    toBeAdded.add(sneaker);
    increaseItems();
  }

  void transferToCart() {
    for (var element in toBeAdded) {
      currentSneakers.add(element);
      listKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 200));
    }
    toBeAdded.clear();
    updatePrice();
    update();
  }

  void removeFromCart(int index) {
    listKey.currentState!.removeItem(
        index, (context, animation) => const SizedBox(),
        duration: const Duration(milliseconds: 100));
    currentSneakers.removeAt(index);
    decreaseItems();
    updatePrice();
    update();
  }
}
