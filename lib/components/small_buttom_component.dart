import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class SmallButtomComponent extends StatelessWidget {
  final String title;
  final Function function;

  SmallButtomComponent({@required this.title, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 30,
        width: 90,
        decoration: BoxDecoration(
            color: Style.primary, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            title,
            style: Style.smallButtonText,
          ),
        ),
      ),
    );
  }
}
