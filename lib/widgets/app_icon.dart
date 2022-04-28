import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color backgroundColor; 
  final Color iconColor;
  final double iconSize;

  
  
     const AppIcon({ Key? key,  this.size = 40, required this.icon, this.backgroundColor = const Color(0xFFfcf4e4),  this.iconColor =const Color(0xFF765d54), this.iconSize =16 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size/2),
      ),
      child: Icon(icon , color: iconColor, size: iconSize),
    );
  }
}