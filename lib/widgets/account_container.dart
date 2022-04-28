
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const AccountContainer({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20),
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          left: Dimensions.width20,
          bottom: Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 1,
          color: Colors.grey.withOpacity(0.2),
          )
          ],
      ),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            iconColor: Colors.white,
            backgroundColor: color,
            size: Dimensions.height20*2.5,
            iconSize: Dimensions.isconSize24,
          ),
          SizedBox(
            width: Dimensions.width20,
          ),
          BigText(text: text),
        ],
      ),
    );
  }
}
