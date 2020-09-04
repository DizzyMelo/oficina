import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class MainTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;

  MainTextFieldComponent(
      {@required this.controller, @required this.icon, @required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Style.textField,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            size: 15,
          ),
          hintText: hint,
          hintStyle: Style.textField,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: Colors.grey[800],
          ))),
    );
  }
}
