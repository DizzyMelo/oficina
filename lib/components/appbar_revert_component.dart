import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/shared/style.dart';

class AppBarRevertComponent extends StatelessWidget {
  final IconData icon;
  final String title;

  AppBarRevertComponent({this.icon, this.title});
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
                  color: Colors.grey[100],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? '',
                  style: Style.pageTitleTextRevert,
                ),
              ],
            ),
            IconButton(
                icon: Icon(
                  LineIcons.close,
                  color: Colors.grey[100],
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
