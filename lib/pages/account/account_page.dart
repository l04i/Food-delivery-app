import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/data/models/user_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_container.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user;
    bool _userLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserData().then((status) {
        if (status.isSuccess) {
          user = Get.find<UserController>().userModel;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (_userLoggedIn) {
          if (userController.isloading) {
            Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: Dimensions.height20),
            width: double.maxFinite,
            child: userController.isloading
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ))
                : Column(
                    children: [
                      AppIcon(
                        icon: Icons.person,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.height15 * 10,
                        iconSize: Dimensions.height15 * 5,
                      ),
                      SizedBox(height: Dimensions.height30),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AccountContainer(
                                  icon: Icons.person,
                                  color: AppColors.mainColor,
                                  text: user!.name),
                              AccountContainer(
                                  icon: Icons.phone,
                                  color: AppColors.yellowColor,
                                  text: user!.phone),
                              AccountContainer(
                                  icon: Icons.email,
                                  color: AppColors.yellowColor,
                                  text: user!.email),
                              AccountContainer(
                                  icon: Icons.location_on,
                                  color: AppColors.yellowColor,
                                  text: "Fill in your address"),
                              AccountContainer(
                                  icon: Icons.message_outlined,
                                  color: Colors.redAccent,
                                  text: "Messages"),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .isUserLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountContainer(
                                    icon: Icons.logout,
                                    color: Colors.redAccent,
                                    text: "Logout"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height20*8,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiu20),
                  image: DecorationImage(
                    
                    fit: BoxFit.cover,
                    image:AssetImage("assets/image/signintocontinue.png") 
                    ),
                ),
              ),
            SizedBox(height: Dimensions.height15,),
             GestureDetector(
               onTap: (){
                 Get.toNamed(RouteHelper.getSignInPage());
               },
               child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiu20),
                    color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Sign in", size: Dimensions.font26, color: Colors.white)),
                ),
             ),
            ],
          );
        }
      }),
    );
  }
}
