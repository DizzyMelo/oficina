import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class LoadingComponent extends StatelessWidget {
  final bool delete;

  LoadingComponent({this.delete});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
              delete != null && delete ? Colors.red : Style.primary),
        ),
      ),
    );
  }
}
