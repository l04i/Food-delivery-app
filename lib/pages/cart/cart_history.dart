import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_date_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    var CartHistoryList =
        Get.find<CartController>().getCartHistory().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    Map<String, int> getCartItemsPerOrder() {
      for (var element in CartHistoryList) {
        if (cartItemsPerOrder.containsKey(element.time)) {
          cartItemsPerOrder.update(element.time!, (value) => ++value);
        } else {
          cartItemsPerOrder.putIfAbsent(element.time!, () => 1);
        }
      }
      return cartItemsPerOrder;
    }

    cartItemsPerOrder = getCartItemsPerOrder();

    List<int> cartITemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> ordersPerTime = cartITemsPerOrderToList();
    int listCounter = 0;
     Widget timeWidget(int index) {
       var outputDate =DateTime.now().toString();
    if(index< CartHistoryList.length){
      var date = CartHistoryList[listCounter].time!;
      DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

      var outputDate = outputFormat.format(inputDate);
    }
      return BigText(text: outputDate);
    
  }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height20 * 5,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          CartHistoryList.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                      child: NoDataPage(
                    text: "You didn'\t buy anything",
                    imagePath: "assets/image/empty_box.png",
                  )))
              : Expanded(
                  child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for (int i = 0; i < cartItemsPerOrder.length; i++)
                          Container(
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(ordersPerTime[i],
                                          (index) {
                                        if (listCounter <
                                            CartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    right:
                                                        Dimensions.width10 / 2),
                                                width: Dimensions.width20 * 5,
                                                height: Dimensions.height20 * 5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radiu15 /
                                                              2),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants.baseUrl +
                                                              AppConstants
                                                                  .uploadURL +
                                                              CartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!)),
                                                ),
                                              )
                                            : Container();
                                      }),
                                    ),
                                    Container(
                                      height: Dimensions.height20 * 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SmallText(
                                            text: "Total",
                                            color: AppColors.titleColor,
                                          ),
                                          BigText(
                                              text:
                                                  ordersPerTime[i].toString() +
                                                      " Items"),
                                          GestureDetector(
                                            onTap: () {
                                              var orderTime =
                                                  cartOrderTimeToList();
                                              Map<int, CartModel> moreItems =
                                                  {};
                                              for (int j = 0;
                                                  j < CartHistoryList.length;
                                                  j++) {
                                                if (CartHistoryList[j].time ==
                                                    orderTime[i]) {
                                                  moreItems.putIfAbsent(
                                                      CartHistoryList[j].id!,
                                                      () => CartHistoryList[j]);
                                                }
                                              }
                                              Get.find<CartController>()
                                                  .setItems = moreItems;
                                              Get.find<CartController>()
                                                  .addToCartList();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
                                                  vertical:
                                                      Dimensions.height10 / 2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.mainColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radiu15 / 2),
                                              ),
                                              child: SmallText(
                                                text: "one more",
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
