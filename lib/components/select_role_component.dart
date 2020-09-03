import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class SelectRoleComponent extends StatelessWidget {
  final String title;
  final bool selected;
  final Function function;

  SelectRoleComponent(
      {@required this.title, @required this.selected, @required this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            height: 15,
            width: 15,
            duration: Duration(milliseconds: 350),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Style.secondaryColor),
                shape: BoxShape.circle,
                color: selected ? Style.primaryColor : Style.secondaryColor),
          ),
          SizedBox(
            width: 10,
          ),
          Text(title)
        ],
      ),
    );
  }
}
