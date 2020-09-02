import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class MediumButtomComponent extends StatelessWidget {
  final String title;
  final Function function;

  MediumButtomComponent({@required this.title, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 45,
        width: 150,
        decoration: BoxDecoration(
            color: Style.primary, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            title,
            style: Style.mainButtonText,
          ),
        ),
      ),
    );
  }
}
