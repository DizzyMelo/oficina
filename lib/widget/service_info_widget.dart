import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class ServiceInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final Function function;
  final IconData icon;

  ServiceInfoWidget(this.title, this.value, this.function, this.icon);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 15,),
              SizedBox(width: 10,),
              Text(
                title,
                style: Style.valueTitleText,
              ),
            ],
          ),
          Text(value, style: Style.valueText),
        ],
      ),
    );
  }
}
