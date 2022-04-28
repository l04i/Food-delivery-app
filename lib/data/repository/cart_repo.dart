import 'dart:convert';

import 'package:food_delivery/data/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  SharedPreferences sharedPreferences;
  CartRepo({
    required this.sharedPreferences,
  });

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.cartListKey, cart);
  }

  List<CartModel> getCartList() {
    List<String> cart = [];
    if (sharedPreferences.containsKey(AppConstants.cartListKey)) {
      cart = sharedPreferences.getStringList(AppConstants.cartListKey)!;
    }

    List<CartModel> cartList = [];
    for (var element in cart) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

  void addToCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryKey)!;
    }
    for (var element in cart) {
      cartHistory.add(element);
    }

    sharedPreferences.setStringList(AppConstants.cartHistoryKey, cartHistory);
    clearCart();
  }

  List<CartModel> getCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryKey)!;
    }
    List<CartModel> cartHistoryList = [];
    for (var element in cartHistory) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartHistoryList;
  }

  void clearCart() {
    sharedPreferences.remove(AppConstants.cartListKey);
    cart = [];
  }

  void test() {
    sharedPreferences.remove(AppConstants.cartHistoryKey);
    sharedPreferences.remove(AppConstants.cartListKey);
  }

  void clearCartHistory(){
    clearCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.cartHistoryKey);
    
  }
}
