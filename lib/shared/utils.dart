import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/shared/style.dart';

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

  static String formatMoney(double value) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          symbol: 'R\$',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
          //compactFormatType: CompactFormatType.sort
        ));

    return fmf.output.symbolOnLeft;
  }

  static Text validadeAmount(ProductModel p) {
    int qtd = int.parse(p.qtd);
    int qtdMin = int.parse(p.qtdMin);

    if (qtd > qtdMin) {
      return Text(
        '$qtd itens ',
        style: Style.qtdOkText,
      );
    }else if(qtd == qtdMin){
      return Text(
        '$qtd itens ',
        style: Style.qtdOkWarning,
      );
    } else{
      return Text(
        '$qtd itens ',
        style: Style.qtdOkDanger,
      );
    }
  }
}
