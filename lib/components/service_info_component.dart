import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class ServiceInfoComponent extends StatelessWidget {
  final String title;
  final String info;

  ServiceInfoComponent({@required this.title, @required this.info});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Style.valueTitleText,
          ),
          Text(
            info,
            style: Style.valueText,
          ),
        ],
      ),
    );
  }
}
