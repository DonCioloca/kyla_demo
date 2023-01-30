import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/cart_screen_controller.dart';
import 'package:kyla_demo/helpers/screen_helpers.dart';
import 'package:kyla_demo/presentation/screens/cart%20screen/widgets/cart_item.dart';

import '../../../models/sneaker_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartScreenController cartScreenController =
      Get.put(CartScreenController());

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => cartScreenController.transferToCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: GetBuilder<CartScreenController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backIcon(),
              topSection(),
              const Divider(
                color: Colors.grey,
              ),
              shoppingList(),
              bottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget backIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10.0),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.arrow_right_alt_sharp,
            color: Colors.grey.shade600,
            size: 36.0,
          ),
        ),
      ),
    );
  }

  Widget topSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'My Bag',
            style: TextStyle(
                color: Colors.black,
                fontSize: 36.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Total ${cartScreenController.totalItems} items',
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget shoppingList() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: cartScreenController.currentSneakers.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        key: cartScreenController.listKey,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) =>
                SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(0.0, -0.1), end: const Offset(0.0, 0.0))
              .animate(animation),
          child: CartItem(
            model: SneakerModel(
                maker: cartScreenController.currentSneakers[index].maker,
                model: cartScreenController.currentSneakers[index].model,
                image: cartScreenController.currentSneakers[index].image,
                price: cartScreenController.currentSneakers[index].price),
            index: index,
          ),
        ),
      ),
    );
  }

  Widget bottomSection() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${cartScreenController.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          button(),
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 44.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            backgroundColor: Colors.pinkAccent,
            maximumSize: const Size(double.infinity, 45.0),
            minimumSize: const Size(double.maxFinite, 45.0)),
        onPressed: () {},
        child: const Text(
          'NEXT',
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
}
