import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/cart_screen_controller.dart';
import 'package:kyla_demo/helpers/screen_helpers.dart';
import 'package:kyla_demo/models/sneaker_model.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.model, required this.index})
      : super(key: key);

  final SneakerModel model;
  final int index;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> with TickerProviderStateMixin {
  late AnimationController _sneakerAnimationController;
  late AnimationController _bubbleAnimationController;
  late AnimationController _detailsAnimationController;
  late final Animation<double> _sneakerAnimation;
  bool detailsVisibility = false;

  final CartScreenController cartScreenController =
      Get.put(CartScreenController());

  @override
  void initState() {
    _detailsAnimationController = AnimationController(
        reverseDuration: const Duration(milliseconds: 100),
        vsync: this,
        duration: const Duration(milliseconds: 600),
        lowerBound: 0.0)
      ..forward();
    _bubbleAnimationController = AnimationController(
        reverseDuration: const Duration(milliseconds: 100),
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.0)
      ..forward();
    _sneakerAnimationController = AnimationController(
        reverseDuration: const Duration(milliseconds: 100),
        vsync: this,
        duration: const Duration(milliseconds: 2000),
        lowerBound: 0.0)
      ..forward();
    _sneakerAnimation = CurvedAnimation(
        parent: _sneakerAnimationController, curve: Curves.elasticOut);
    super.initState();
  }

  @override
  void dispose() {
    _sneakerAnimationController.dispose();
    _detailsAnimationController.dispose();
    _bubbleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: 180.0,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              bubble(),
              details(),
            ],
          ),
          image(),
        ],
      ),
    );
  }

  Widget bubble() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ScaleTransition(
        scale: _bubbleAnimationController,
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget details() {
    return Expanded(
      child: SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(0.5, 0.0), end: const Offset(0.0, 0.0))
            .animate(_detailsAnimationController),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60.0, 32.0, 10.0, 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.model.maker} ${widget.model.model}',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
              Text(
                '\$${widget.model.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buttons('-', () {
                    cartScreenController.removeFromCart(widget.index);
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text('0',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600)),
                  ),
                  buttons('+', () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Positioned(
      bottom: 30.0,
      left: 20.0,
      child: ScaleTransition(
        scale: _sneakerAnimation,
        child: SizedBox(
          width: 160.0,
          child: Image.asset(widget.model.image),
        ),
      ),
    );
  }

  ElevatedButton buttons(String text, Function onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          backgroundColor: Colors.grey.shade200,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          maximumSize: const Size(36.0, 36.0),
          minimumSize: const Size(36.0, 36.0)),
      onPressed: () {
        onTap();
      },
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
        ),
      ),
    );
  }
}
