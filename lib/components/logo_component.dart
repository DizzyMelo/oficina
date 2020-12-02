import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  final double width;
  final double height;

  LogoComponent({this.height = 70, this.width = 70});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/logo.png'),
        ),
      ),
    );
  }
}
