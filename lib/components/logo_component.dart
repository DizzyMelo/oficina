import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/logo.png'),
        ),
      ),
    );
  }
}
