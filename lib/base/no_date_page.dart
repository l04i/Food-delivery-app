import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  NoDataPage({
    Key? key,
    required this.text,
    this.imagePath = 'assets/image/empty_cart.png',
  }) : super(key: key);
  final String text;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            width: MediaQuery.of(context).size.height * 0.22,
            height: MediaQuery.of(context).size.height * 0.22,
            child: Image.asset(imagePath)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0175,
            color: Theme.of(context).disabledColor,
            
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
