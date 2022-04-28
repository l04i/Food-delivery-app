import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import 'small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
 
  const IconAndText({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Icon(icon, color: iconColor, size: Dimensions.isconSize24,),
      const SizedBox(width: 5,),
      SmallText(text: text ,),
      
      ],
    );
  }
}
