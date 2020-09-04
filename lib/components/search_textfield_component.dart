import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class SearchTextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function function;

  SearchTextFieldComponent(
      {@required this.controller,
      @required this.hint,
      @required this.function});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Style.searchText,
      onSubmitted: function,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: Style.searchText,
          prefixIcon: Icon(
            Icons.search,
            size: 15,
          )),
    );
  }
}
