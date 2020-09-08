import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class ActionTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool mandatory;
  final Function function;

  ActionTextFieldComponent(
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
          controller: controller,
          style: Style.textField,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 15,
            ),
            suffixIcon:
                FlatButton(onPressed: function, child: Text('ATUALIZAR')),
            labelText: hint,
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
