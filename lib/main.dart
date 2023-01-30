import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyla_demo/controllers/cart_screen_controller.dart';
import 'package:kyla_demo/controllers/main_screen_controller.dart';
import 'package:kyla_demo/presentation/screens/main%20screen/main_screen.dart';

void main() {
  Get.put(MainScreenController(), permanent: true);
  Get.put(CartScreenController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
