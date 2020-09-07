import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:oficina/components/medium_buttom_component.dart';
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

  static double clearPrice(String value) {
    double price = double.parse(value
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .replaceAll(' ', '')
        .trim());
    return price;
  }

  static String clearPhone(String value) {
    String price = value
        .replaceAll('-', '')
        .replaceAll('(', '.')
        .replaceAll(')', '')
        .replaceAll(' ', '')
        .trim();
    return price;
  }

  static String generateRandomPassword() {
    String randomTime = DateTime.now().millisecondsSinceEpoch.toString();
    String password =
        randomTime.substring(randomTime.length - 6, randomTime.length);
    return password;
  }

  static Map<String, dynamic> validateUserData(Map<String, dynamic> data) {
    if (data['email'].toString().isEmpty) {
      data.remove('email');
    }
    if (data['cpfcnpj'].toString().isEmpty) {
      data.remove('cpfcnpj');
    }
    if (data['secondaryphone'].toString().isEmpty) {
      data.remove('secondaryphone');
    }

    return data;
  }

  static Map<String, dynamic> validateProductData(Map<String, dynamic> data) {
    if (data['description'].toString().isEmpty) {
      data.remove('description');
    }
    if (data['code'].toString().isEmpty) {
      data.remove('code');
    }
    if (data['minimum_amount'].toString().isEmpty) {
      data.remove('minimum_amount');
    }
    if (data['price_bought'].toString().isEmpty) {
      data.remove('price_bought');
    }
    return data;
  }

  static void confirmDialog(String title, String message, Function function,
      String buttonTitle, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: Style.dialogTitle),
          content: Container(
            height: 180,
            child: Center(
              child: Text(
                message,
                style: Style.dialogMessage,
              ),
            ),
          ),
          actions: <Widget>[
            MediumButtomComponent(title: buttonTitle, function: function)
          ],
        );
      },
    );
  }
}
