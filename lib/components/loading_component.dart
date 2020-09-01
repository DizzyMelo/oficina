import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Style.primary),
      ),
    );
  }
}
