import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/data/models/sign_up_body_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final List signUpImgs = ['t.png', 'f.png', 'g.png'];

  void registration() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar('Type in your email', title: 'Email');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('Type in a valid email address',
          title: 'Valid Email Adress');
    } else if (password.isEmpty) {
      showCustomSnackBar('Type in your pssword', title: 'Password');
    } else if (name.isEmpty) {
      showCustomSnackBar('Type in your name', title: 'Name');
    } else if (phone.isEmpty) {
      showCustomSnackBar('Type in your phone number', title: 'Phone Number');
    } else if (password.length < 6) {
      showCustomSnackBar('Password can\'tt be less than 6 digits',
          title: 'Password');
    } else {
      SignUpBody signUpBody = SignUpBody(
          email: email, password: password, name: name, phone: phone);
      Get.find<AuthController>().registration(signUpBody).then((status) {
        if (status.isSuccess) {
          Get.offNamed(RouteHelper.getIntial());
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
              height: Dimensions.height20,
            ),
            AppTextField(
              controller: _nameController,
              icon: Icons.person,
              hintText: "Name",
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              controller: _phoneController,
              icon: Icons.phone,
              hintText: "Phone",
            ),
            SizedBox(
              height: Dimensions.height20 * 2,
            ),
            GestureDetector(
              onTap: registration,
              child: Container(
                height: Dimensions.screenHeight / 13,
                width: Dimensions.screenWidth / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height30),
                  color: AppColors.mainColor,
                ),
                child: GetBuilder<AuthController>(
                  builder: (authContoller) {
                    return Center(
                        child: authContoller.isloading? CircularProgressIndicator(color: Colors.white,) :BigText(
                      text: "Sign Up",
                      size: Dimensions.font20 * 1.5,
                      color: Colors.white,
                    ));
                  }
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                    fontSize: Dimensions.font20, color: Colors.grey[500]),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: " Sign in",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.screenHeight * 0.035),
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(
                    fontSize: Dimensions.font16, color: Colors.grey[500]),
              ),
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage:
                        AssetImage('assets/image/' + signUpImgs[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
