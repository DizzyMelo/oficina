import 'package:flutter/material.dart';
import 'package:oficina/shared/menu_list.dart';
import 'package:oficina/shared/style.dart';

class MenuItemComponent extends StatelessWidget {
  final MenuItem item;
  final int index;

  MenuItemComponent(this.item, this.index);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, item.screen),
      child: Container(
        margin: index.isEven
            ? EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10)
            : EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 5),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: item.color, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              item.icon,
              color: Colors.white,
            ),
            Text(
              item.title,
              style: Style.menuItemText,
            )
          ],
        ),
      ),
    );
  }
}
