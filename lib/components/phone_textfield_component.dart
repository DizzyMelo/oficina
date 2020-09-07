import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:oficina/shared/style.dart';

class PhoneTextFieldComponent extends StatelessWidget {
  final MaskedTextController controller;
  final IconData icon;
  final String hint;
  final Function function;
  final bool mandatory;

  PhoneTextFieldComponent(
      {@required this.controller,
      @required this.icon,
      @required this.hint,
      @required this.function,
      this.mandatory = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: function,
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
