import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_date_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 2,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconSize: Dimensions.isconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getIntial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconSize: Dimensions.isconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconSize: Dimensions.isconSize24,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  var _cartList = cartController.getItems;
                  return _cartList.isEmpty
                      ? NoDataPage(text: "cart is empty")
                      : ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return SizedBox(
                              width: double.maxFinite,
                              height: Dimensions.height10 * 10,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProduct
                                              .indexOf(
                                                  _cartList[index].product);
                                      if (popularIndex >= 0) {
                                        Get.toNamed(RouteHelper.getPopularFood(
                                            popularIndex, 'cartpage'));
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProduct
                                            .indexOf(_cartList[index].product);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar('Product History',
                                              "Products review is not available for history",
                                              backgroundColor:
                                                  AppColors.mainColor,
                                              colorText: Colors.white);
                                        } else {
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedIndex,
                                                  'cartpage'));
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      height: Dimensions.height20 * 5,
                                      width: Dimensions.width20 * 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiu20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstants.baseUrl +
                                                    AppConstants.uploadURL +
                                                    _cartList[index].img!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54),
                                          SizedBox(height: Dimensions.height15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text:
                                                      '\$ ${_cartList[index].price!}',
                                                  color: Colors.redAccent),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    Dimensions.height10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radiu20),
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            _cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    BigText(
                                                        text: _cartList[index]
                                                            .quantity!
                                                            .toString()),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            _cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
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
                                  ),
                                ],
                              ),
                            );
                          });
                }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
            height: Dimensions.bottomHeightBar,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiu20 * 2),
                    topRight: Radius.circular(Dimensions.radiu20 * 2)),
                color: AppColors.buttonBackgroundColor),
            child: controller.getItems.isEmpty
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.height20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiu20),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(
                                text: '\$' + controller.totalAmount.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().isUserLoggedIn()) {
                              controller.addToHistory();
                            }
                            else{
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.height20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiu20),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
