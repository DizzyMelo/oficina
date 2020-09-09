import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/shared/style.dart';

class AppBarComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function function;

  AppBarComponent({this.icon, this.title, this.function});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Style.primaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? '',
                  style: Style.pageTitleText,
                ),
              ],
            ),
            IconButton(
                icon: Icon(LineIcons.close),
                onPressed: function == null
                    ? () {
                        Navigator.pop(context);
                      }
                    : function),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
