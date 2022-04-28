import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;



  void _loadResources() async {

    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
    // Get.find<CartController>().test();
  }

  @override
  void initState() {
    _loadResources();
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Timer(
        const Duration(seconds: 3), () => Get.toNamed(RouteHelper.getIntial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: _animation,
              child: Center(
                  child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ))),
          Center(
              child: Image.asset(
            "assets/image/logo part 2.png",
            width: Dimensions.splashImg,
          )),
        ],
      ),
    );
  }
}
