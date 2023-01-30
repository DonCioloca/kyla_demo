import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kyla_demo/models/sneaker_model.dart';

class NewItemCard extends StatelessWidget {
  const NewItemCard({Key? key, required this.model}) : super(key: key);

  final SneakerModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 230,
          width: 170,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              image(),
              details(),
            ],
          ),
        ),
        redLabel(),
        arrow(),
      ],
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        width: 150.0,
        child: Transform.rotate(
            angle: math.pi / 8, child: Image.asset(model.image)),
      ),
    );
  }

  Widget details() {
    return Flexible(
      child: Text(
        '${model.maker} ${model.model}\n\$${model.price.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget redLabel() {
    return Positioned(
      left: 14.0,
      top: 14.0,
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
          color: Colors.pinkAccent,
          child: const Text(
            'NEW',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  Widget arrow() {
    return Positioned(
      right: 14.0,
      top: 14.0,
      child: Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey.shade600,
        size: 28.0,
      ),
    );
  }
}
