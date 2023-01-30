import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/product_screen_controller.dart';
import 'package:kyla_demo/helpers/screen_helpers.dart';
import 'package:kyla_demo/models/sneaker_model.dart';

import '../../../controllers/cart_screen_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.model, required this.index})
      : super(key: key);

  final SneakerModel model;
  final int index;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bubbleController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..forward();
  late final Animation<double> _bubbleAnimation = CurvedAnimation(
    parent: _bubbleController,
    curve: Curves.linear,
  );

  final ProductScreenController productScreenController =
      Get.put(ProductScreenController());

  final CartScreenController cartScreenController =
      Get.put(CartScreenController());

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          bubble(),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 0.0),
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  topBar(),
                  image(),
                  gallery(),
                  divider(),
                  details(),
                  description(),
                  moreTitle(),
                  sizeTitle(),
                  sizesList(),
                  button(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bubble() {
    return Positioned(
      right: -200,
      top: -200,
      child: Hero(
        tag: 'bubble${widget.index}',
        child: ScaleTransition(
            scale: _bubbleAnimation,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(widget.index),
              ),
            )),
      ),
    );
  }

  Widget topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.arrow_right_alt_sharp,
              color: Colors.white,
              size: 36.0,
            ),
          ),
        ),
        const Text(
          'Nike',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Material(
          color: getColor(widget.index),
          elevation: 5.0,
          shape: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border_outlined,
              size: 24.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget image() {
    return ScaleTransition(
      scale: _bubbleAnimation,
      child: SizedBox(
        width: screenWidth * 0.9,
        child: Image.asset(
          widget.model.image,
        ),
      ),
    );
  }

  Widget gallery() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) => galleryItem(),
        separatorBuilder: (context, index) => const SizedBox(
          width: 14.0,
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
      child: Divider(
        thickness: 3.0,
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget details() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.model.model,
          style: const TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$${widget.model.price.toStringAsFixed(2)}',
          style: const TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget description() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'The ${widget.model.model} is the new top notch technology '
          'when it comes to shoe comfort and fit. Fashionable and comfortable.',
          style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              height: 1.4),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget moreTitle() {
    return Text(
      'MORE DETAILS',
      style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),
    );
  }

  Widget sizeTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Size',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          GetBuilder<ProductScreenController>(
            id: 'sizeType',
            builder: (controller) => SizedBox(
              height: 16.0,
              child: ListView.builder(
                itemCount: controller.sizeTypes.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.selectSizeType(index);
                    },
                    child: Text(
                      controller.sizeTypes[index],
                      style: TextStyle(
                          color: controller.selectedSizeType == index
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sizesList() {
    return GetBuilder<ProductScreenController>(
      id: 'size',
      builder: (controller) => SizedBox(
        height: 50.0,
        child: ListView.builder(
          itemCount: controller.sizes.length + 1,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: index != 0 ? 8.0 : 0.0),
              child: index == 0
                  ? tryItItem()
                  : sizeItem(
                      controller.sizes[index - 1],
                      controller.selectedSize == controller.sizes[index - 1]
                          ? true
                          : false)),
        ),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              backgroundColor: Colors.pinkAccent,
              maximumSize: const Size(double.infinity, 45.0),
              minimumSize: const Size(double.maxFinite, 45.0)),
          onPressed: () {
            cartScreenController.addToCart(widget.model);
          },
          child: const Text(
            'ADD TO BAG',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          )),
    );
  }

  Widget galleryItem() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      width: 80.0,
      height: 90.0,
      child: Transform.rotate(
          angle: math.pi / 8, child: Image.asset(widget.model.image)),
    );
  }

  Widget sizeItem(double size, bool isSelected) {
    return GestureDetector(
      onTap: () {
        productScreenController.selectSize(size);
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(color: Colors.grey.shade300),
            color: isSelected ? Colors.black : Colors.white),
        child: Center(
          child: Text(
            size.toString(),
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget tryItItem() {
    return Container(
      width: 90.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white),
      child: Center(
        child: Text(
          'Try it',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Color? getColor(int index) {
    Color? color;
    switch (index) {
      case 0:
        color = Colors.blueAccent;
        break;
      case 1:
        color = Colors.lightBlueAccent;
        break;
      case 2:
        color = Colors.deepOrangeAccent.shade100;
        break;
      default:
        color = Colors.blueAccent;
    }
    return color;
  }
}
