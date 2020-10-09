import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class StatusLabelComponent extends StatelessWidget {
  final String status, label;

  StatusLabelComponent({@required this.status, @required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 5,
            backgroundColor: Utils.selectServiceColor(status),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: Style.mediumDarkText,
          )
        ],
      ),
    );
  }
}
