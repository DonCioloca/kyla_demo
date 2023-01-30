import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/main_screen_controller.dart';

class BrandListItem extends StatelessWidget {
  BrandListItem(
      {Key? key,
      required this.brand,
      required this.isSelected,
      required this.index})
      : super(key: key);

  final String brand;
  final bool isSelected;
  final int index;

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mainScreenController.changeBrand(index);
      },
      child: Text(
        brand,
        style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey.shade400,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
