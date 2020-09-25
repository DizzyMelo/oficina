import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class MainTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool mandatory;
  final int maxlines;
  final bool label;

  MainTextFieldComponent(
      {@required this.controller,
      @required this.icon,
      @required this.hint,
      this.mandatory = false,
      this.maxlines = 1,
      this.label = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          style: Style.textField,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 15,
            ),
            hintText: hint,
            hintStyle: Style.textField,
            labelText: label ? hint : null,
            labelStyle: Style.textField,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        mandatory
            ? Text(
                'O campo acima é obrigatório',
                style: Style.textFieldMandatory,
              )
            : SizedBox(
                height: 5,
              )
      ],
    );
  }
}
