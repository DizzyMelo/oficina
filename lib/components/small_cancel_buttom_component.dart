import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class SmallCancelButtomComponent extends StatelessWidget {
  final String title;
  final Function function;

  SmallCancelButtomComponent({@required this.title, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 35,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            title,
            style: Style.smallCancelButtonText,
          ),
        ),
      ),
    );
  }
}
