import 'package:flutter/material.dart';
import 'package:food_delivery/data/models/cart_model.dart';
import 'package:food_delivery/data/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:food_delivery/data/repository/cart_repo.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });

  Map<int, CartModel> _items = {};
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    int totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            img: value.img,
            name: value.name,
            price: value.price,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          totalQuantity = quantity;
          return CartModel(
            id: product.id,
            name: product.name,
            img: product.img,
            price: product.price,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
            'Item count', "You should add at least one item to the cart!",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (existInCart(product)) {
      quantity = _items[product.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var totalAmount = 0;
    for (int i = 0; i < getItems.length; i++) {
      totalAmount += (getItems[i].quantity! * getItems[i].price!);
    }
    return totalAmount;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (var element in storageItems) {
      _items.putIfAbsent(element.product!.id!, () => element);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistory() {
    return cartRepo.getCartHistory();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void test(){
    cartRepo.test();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }
}
