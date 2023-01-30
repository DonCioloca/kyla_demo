import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/main_screen_controller.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem(
      {Key? key,
      required this.category,
      required this.isSelected,
      required this.index})
      : super(key: key);

  final String category;
  final bool isSelected;
  final int index;

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mainScreenController.changeCategory(index);
      },
      child: Text(
        category,
        style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey.shade400,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
