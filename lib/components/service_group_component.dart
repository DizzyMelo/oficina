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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        height: 40,
        child: Text(title, style: selected ? Style.selectedGroupServiceText : Style.unselectedGroupServiceText,),
        decoration: BoxDecoration(
            color: selected ? Colors.blue : Colors.transparent, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
