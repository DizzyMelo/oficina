import 'package:flutter/material.dart';
import 'package:oficina/shared/menu_list.dart';
import 'package:oficina/shared/style.dart';

class SideMenuComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      color: Style.secondaryColor,
      height: screen.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: MenuList.listMenu.length,
              itemBuilder: (context, index) {
                MenuItem item = MenuList.listMenu[index];
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, item.screen),
                  leading: Icon(
                    item.icon,
                    color: Style.primaryColor,
                  ),

                  // Image.asset(
                  //   'assets/img/${item.img}',
                  //   height: 25,
                  //   width: 25,
                  // ),
                  title: Text(
                    item.title ?? 'no-data',
                    style: Style.optionTitleTextLight,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
