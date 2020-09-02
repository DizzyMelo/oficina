import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/shared/style.dart';

class Utils {
  static void showInSnackBar(
      String value, Color color, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: color,
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
        amount: value ?? 0,
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

  static String getCars(List<Carro> cars) {
    if (cars.isEmpty) {
      return 'Sem carro';
    } else {
      String c = '';
      cars.forEach((element) {
        c += '${element.modelo} - ';
      });
      c = c.substring(0, c.length - 2);
      return c;
    }
  }

  static String formatDate(DateTime dt) {
    if (dt == null) {
      return 'Não Informado';
    }
    String dia = dt.day < 10 ? '0${dt.day}' : '${dt.day}';
    String mes = dt.month < 10 ? '0${dt.month}' : '${dt.month}';

    String hora = dt.hour < 10 ? '0${dt.hour}' : '${dt.hour}';
    String minuto = dt.minute < 10 ? '0${dt.minute}' : '${dt.minute}';

    return '$dia/$mes/${dt.year} às $hora:$minuto';
  }

  static Text validadeAmount(ProductModel p) {
    int qtd = int.parse(p.qtd);
    int qtdMin = int.parse(p.qtdMin);

    if (qtd > qtdMin) {
      return Text(
        '$qtd itens ',
        style: Style.qtdOkText,
      );
    } else if (qtd == qtdMin) {
      return Text(
        '$qtd itens ',
        style: Style.qtdOkWarning,
      );
    } else {
      return Text(
        '$qtd itens ',
        style: Style.qtdOkDanger,
      );
    }
  }
}
