import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar('Type in your email', title: 'Email');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Type in a valid email address',
          title: 'Valid Email Adress');
    } else if (password.isEmpty) {
      showCustomSnackBar('Type in your pssword', title: 'Password');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can\'tt be less than 6 digits',
          title: 'Password');
    } else {
      Get.find<AuthController>().login(email, password).then((status) {
        if (status.isSuccess) {
             print("YESS");
          Get.toNamed(RouteHelper.getCartPage());
       
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),
            SizedBox(
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/image/logo part 1.png"),
                  radius: Dimensions.radiu20 * 4,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20 * 3.5,
                          fontWeight: FontWeight.bold)),
                  SmallText(
                    text: "Sign in into your account",
                    color: Colors.grey,
                    size: Dimensions.font20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            AppTextField(
              controller: _emailController,
              icon: Icons.email,
              hintText: "Email",
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              controller: _passwordController,
              icon: Icons.vpn_key,
              hintText: "Password",
              isPassword: true,
            ),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                height: Dimensions.screenHeight / 13,
                width: Dimensions.screenWidth / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height30),
                  color: AppColors.mainColor,
                ),
                child: GetBuilder<AuthController>(builder: (authController) {
                  return  Center(
                          child: authController.isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : BigText(
                          text: "Sign In",
                          size: Dimensions.font20 * 1.5,
                          color: Colors.white,
                        ));
                }),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                  text: "Don'\tt have an account?",
                  style: TextStyle(
                      fontSize: Dimensions.font20, color: Colors.grey[500]),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(SignUpPage()),
                      text: " Create",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.035),
          ],
        ),
      ),
    );
  }
}
