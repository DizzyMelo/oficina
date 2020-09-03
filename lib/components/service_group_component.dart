import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class ServiceGroupComponent extends StatelessWidget {
  final String title;
  final Function _function;
  final bool selected;

  ServiceGroupComponent(this.title, this._function, this.selected);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _function,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Style.unselectedGroupServiceText,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 4,
                width: selected ? 110 : 4,
                decoration: BoxDecoration(
                    color: Style.primaryColor,
                    borderRadius: BorderRadius.circular(4)),
              ),
            ],
          ),
        ));
  }
}
