import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/models/sneaker_model.dart';
import 'package:kyla_demo/presentation/screens/product%20screen/product_screen.dart';

class SpotlightCard extends StatefulWidget {
  const SpotlightCard({Key? key, required this.model, required this.index})
      : super(key: key);

  final SneakerModel model;
  final int index;

  @override
  State<SpotlightCard> createState() => _SpotlightCardState();
}

class _SpotlightCardState extends State<SpotlightCard>
    with TickerProviderStateMixin {
  double sneakerScale = 1;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        reverseDuration: const Duration(milliseconds: 100),
        vsync: this,
        duration: const Duration(milliseconds: 50),
        lowerBound: 0.8)
      ..forward();
    _animationController.addListener(() {
      setState(() {
        sneakerScale = _animationController.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        _animationController.reverse();
      },
      onLongPressEnd: (_) {
        _animationController.forward();
      },
      onTap: () async {
        await _animationController.reverse();
        await _animationController.forward();
        Get.to(() => ProductScreen(model: widget.model, index: widget.index),
            transition: Transition.fade);
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Hero(
            tag: 'bubble${widget.index}',
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14.0),
              width: 220,
              height: 320,
              decoration: BoxDecoration(
                  color: getColor(widget.index),
                  borderRadius: const BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      maker(),
                      favoritesIcon(),
                    ],
                  ),
                  model(),
                  price(),
                  const Spacer(),
                  arrow(),
                ],
              ),
            ),
          ),
          image(),
        ],
      ),
    );
  }

  Widget maker() {
    return Text(
      widget.model.maker,
      style: const TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
    );
  }

  Widget favoritesIcon() {
    return const Icon(
      Icons.favorite_border_outlined,
      color: Colors.white,
      size: 28.0,
    );
  }

  Widget model() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        widget.model.model,
        style: const TextStyle(
            color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget price() {
    return Text(
      '\$${widget.model.price.toStringAsFixed(2)}',
      style: const TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400),
    );
  }

  Widget arrow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(
          Icons.arrow_right_alt_sharp,
          color: Colors.white,
          size: 32.0,
        )
      ],
    );
  }

  Widget image() {
    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Transform.scale(
          scale: sneakerScale,
          child: Image.asset(widget.model.image),
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
