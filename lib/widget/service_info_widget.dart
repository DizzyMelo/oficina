import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class ServiceInfoWidget extends StatelessWidget {
  final String title;
  final String value;

  ServiceInfoWidget(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Style.valueTitleText,
        ),
        Text(value, style: Style.valueText),
      ],
    );
  }
}
