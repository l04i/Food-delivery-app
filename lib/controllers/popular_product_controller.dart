import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/models/cart_model.dart';
import 'package:food_delivery/data/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import 'package:food_delivery/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });
  List<dynamic> _popularProduct = [];
  bool _isLoaded = false;
  int _quantity = 0;
  int _inCartItems = 0;
  late CartController _cart;

  bool get isLoaded => _isLoaded;
  int get quantity => _quantity;
  int get inCartItems => _quantity + _inCartItems;

  List<dynamic> get popularProduct => _popularProduct;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getProductList();
    if (response.statusCode == 200) {
      _popularProduct = [];
      _popularProduct.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity + _inCartItems > 20) {
      Get.snackbar('Item count', "You can'\t add more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else if (quantity + _inCartItems < 0) {
      Get.snackbar('Item count', "You can'\t reduce more ",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);

      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems; 
     }
}
