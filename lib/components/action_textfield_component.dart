import 'package:flutter/material.dart';
import 'package:oficina/components/small_buttom_component.dart';
import 'package:oficina/shared/style.dart';

class ActionTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final String actionText;
  final bool mandatory;
  final Function function;
  final int maxlines;
  final bool hasIcon;

  ActionTextFieldComponent(
      {@required this.controller,
      @required this.icon,
      @required this.hint,
      @required this.function,
      this.actionText = 'ATUALIZAR',
      this.mandatory = false,
      this.maxlines = 1,
      this.hasIcon = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          style: Style.textField,
          maxLines: maxlines,
          decoration: InputDecoration(
            prefixIcon: hasIcon
                ? Icon(
                    icon,
                    size: 15,
                  )
                : null,
            suffixIcon:
                SmallButtomComponent(title: actionText, function: function),
            //FlatButton(onPressed: function, child: Text(actionText)),
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
