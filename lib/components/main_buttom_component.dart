import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class MainButtomComponent extends StatelessWidget {
  final String title;
  final Function function;

  MainButtomComponent({@required this.title, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            color: function == null ? Colors.grey[400] : Style.primary,
            borderRadius: BorderRadius.circular(4)),
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
