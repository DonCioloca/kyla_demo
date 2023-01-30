import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/presentation/screens/cart%20screen/cart_screen.dart';
import 'package:kyla_demo/presentation/screens/main%20screen/widgets/brand_list_item.dart';
import 'package:kyla_demo/presentation/screens/main%20screen/widgets/category_list_item.dart';
import 'package:kyla_demo/presentation/screens/main%20screen/widgets/new_items_card.dart';
import 'package:kyla_demo/presentation/screens/main%20screen/widgets/spotlight_card.dart';

import '../../../controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: bottomNavigationBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 80.0,
              color: Colors.grey.shade200,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                topRow(),
                brandsList(),
                categoriesList(),
                moreItemsRow(),
                newSneakersList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, left: 14.0, right: 14.0),
      child: Row(
        children: [
          const Expanded(
            child: Text('Discover',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
          ),
          topIcons(const Icon(Icons.search)),
          const SizedBox(width: 8.0),
          topIcons(const Icon(Icons.add_alert_outlined))
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<MainScreenController>(
      id: 'navigationBar',
      builder: (navigationBarController) => BottomNavigationBar(
        elevation: 0.0,
        currentIndex: navigationBarController.navigationBarIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.pinkAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26.0,
        selectedIconTheme: const IconThemeData(size: 26.0),
        backgroundColor: Colors.grey.shade200,
        onTap: (newIndex) {
          if (newIndex == 3) {
            Get.to(() => const CartScreen());
          } else {
            navigationBarController.changeNavigationBarIndex(newIndex);
          }
        },
        items: [
          navigationItem(const Icon(Icons.home_outlined)),
          navigationItem(const Icon(Icons.favorite_border_outlined)),
          navigationItem(const Icon(Icons.add_home_outlined)),
          navigationItem(const Icon(Icons.shopping_cart_outlined)),
          navigationItem(const Icon(Icons.person_outline))
        ],
      ),
    );
  }

  Widget brandsList() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
      child: SizedBox(
        height: 40.0,
        child: GetBuilder<MainScreenController>(
          id: 'brandsList',
          builder: (brandListController) => ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: brandListController.brands.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      right: index == brandListController.brands.length - 1
                          ? 0.0
                          : 24.0),
                  child: BrandListItem(
                    brand: brandListController.brands[index],
                    isSelected: index == brandListController.selectedBrandIndex
                        ? true
                        : false,
                    index: index,
                  ))),
        ),
      ),
    );
  }

  Widget categoriesList() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SizedBox(
        height: 300.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: SizedBox(
                height: 30.0,
                child: GetBuilder<MainScreenController>(
                  id: 'categoriesList',
                  builder: (categoriesListController) => ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesListController.category.length,
                      itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.only(left: index != 0 ? 48.0 : 0.0),
                          child: CategoryListItem(
                            category: categoriesListController.category[index],
                            isSelected: categoriesListController
                                        .selectedCategoryIndex ==
                                    index
                                ? true
                                : false,
                            index: index,
                          ))),
                ),
              ),
            ),
            spotlightItemsList(),
          ],
        ),
      ),
    );
  }

  Widget spotlightItemsList() {
    return Expanded(
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: mainScreenController.pageController,
        itemCount: mainScreenController.sneakers.length,
        itemBuilder: (context, index) {
          if (mainScreenController.pageController.position.haveDimensions) {
            return AnimatedBuilder(
              animation: mainScreenController.pageController,
              builder: (BuildContext context, Widget? child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.004)
                  ..scale(math.max(
                      0.85,
                      (1 -
                          (mainScreenController.pageController.page! - index)
                                  .abs() /
                              2)))
                  ..rotateY(-math.min(
                      0.2,
                      (mainScreenController.pageController.page! - index)
                          .abs())),
                child: SpotlightCard(
                  model: mainScreenController.sneakers[index],
                  index: index,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget moreItemsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const Expanded(
            child: Text('More',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
          ),
          Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.grey.shade600,
            size: 32.0,
          )
        ],
      ),
    );
  }

  Widget newSneakersList() {
    return SizedBox(
      height: 230.0,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: index != 0 ? 16.0 : 0.0),
              child: NewItemCard(model: mainScreenController.sneakers[index]))),
    );
  }

  BottomNavigationBarItem navigationItem(Widget icon) {
    return BottomNavigationBarItem(icon: icon, label: '');
  }

  Widget topIcons(Icon icon) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(
        icon.icon,
        color: Colors.black,
        size: 24.0,
      ),
    );
  }
}
