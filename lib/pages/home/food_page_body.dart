import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.00;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewController;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });
    });
  }

  Matrix4 setTrans(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix4 = matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTrans = height * (1 - currentScale) / 2;
      matrix4 = matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      var currentTrans = height * (1 - scaleFactor) / 2;
      matrix4 = matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    }

    return matrix4;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The slider
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: popularProducts.popularProduct.length,
                      itemBuilder: (context, position) {
                        return buildPageItem(
                            position, popularProducts.popularProduct[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //The dots area
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return dotsIndicator(popularProducts.popularProduct.isEmpty
              ? 1
              : popularProducts.popularProduct.length);
        }),

        SizedBox(height: Dimensions.height30),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: BigText(text: "Recommended"),
              margin: EdgeInsets.only(left: Dimensions.width30),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: BigText(text: "."),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: SmallText(text: "Food Pairnig"),
            ),
          ],
        ),

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProduct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index,'home'));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width30),
                        child: Row(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height10),
                              height: Dimensions.listViewImageSize,
                              width: Dimensions.listViewImageSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radiu20),
                                image: DecorationImage(
                                  image: NetworkImage(AppConstants.baseUrl +
                                      AppConstants.uploadURL +
                                      recommendedProduct
                                          .recommendedProduct[index].img!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radiu20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radiu20),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProduct[index].name!),
                                      SizedBox(height: Dimensions.height10),
                                      //SmallText(text: 'With Chinese charastristics'),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                            icon: Icons.circle_sharp,
                                            iconColor: AppColors.iconColor1,
                                            text: "Normal",
                                          ),
                                          IconAndText(
                                            icon: Icons.location_on,
                                            iconColor: AppColors.mainColor,
                                            text: "1.7KM",
                                          ),
                                          IconAndText(
                                            icon: Icons.access_time_rounded,
                                            iconColor: AppColors.iconColor2,
                                            text: "72hours",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget dotsIndicator(int count) {
    return DotsIndicator(
      dotsCount: count,
      position: currentPageValue,
      decorator: DotsDecorator(
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Widget buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = setTrans(index);

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              height: Dimensions.pageViewController,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(AppConstants.baseUrl +
                        AppConstants.uploadURL +
                        popularProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              height: Dimensions.pageViewTextController,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiu20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimensions.height15,
                      Dimensions.height15,
                      Dimensions.height15,
                      Dimensions.height10),
                  child: AppColumn(
                    text: popularProduct.name!,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
