import 'package:flutter/material.dart';

class Utils {
  static void showInSnackBar(
      String value, Color cor, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: cor,
      content: Text(value),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
          label: "FECHAR",
          textColor: Colors.white,
          onPressed: () {
            scaffoldKey.currentState.hideCurrentSnackBar();
          }),
    ));
  }

  static String formatFirstName(String name) {
    var str = name.split(" ");
    return str[0];
  }
}
