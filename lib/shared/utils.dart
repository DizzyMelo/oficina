import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/medium_buttom_component.dart';
import 'package:oficina/components/service_info_component.dart';
import 'package:oficina/components/small_buttom_component.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/detail_service_data_model.dart';
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

  static String calculateProfit(double priceSale, double priceBought) {
    if (priceSale == 0 || priceBought == 0) {
      return '${formatMoney(priceSale)} - 100%';
    }
    return '${formatMoney(priceSale - priceBought)} - ${(((priceSale - priceBought) / priceBought) * 100).toStringAsFixed(0)}%';
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

  changeMaskPhone(String str, MaskedTextController controller) {
    if (str.length >= 4) {
      print(str);
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        controller.mask = '(00) 0000-0000';
      } else {
        controller.mask = '(00) 00000-0000';
      }
    }
  }

  static formatDateReverse(String dt) {
    var res = dt.split('/');
    return '${res[2]}-${res[1]}-${res[0]}';
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
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(' ', '')
        .trim();
    return price;
  }

  static String removeSpecialCharacters(String value) {
    String price = value
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll('.', '')
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
            SmallButtomComponent(title: buttonTitle, function: function)
          ],
        );
      },
    );
  }

  static void confirmFinishService(String title, DetailServiceDataModel service,
      Function function, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: Style.dialogTitle),
          content: Container(
              height: 320,
              width: 400,
              child: Column(
                children: [
                  ServiceInfoComponent(
                      title: 'Cliente',
                      info: service.data.data.client == null
                          ? 'Não informado'
                          : service.data.data.client.name),
                  ServiceInfoComponent(
                      title: 'Veículo',
                      info: service.data.data.car == null
                          ? 'Não informado'
                          : service.data.data.car.name),
                  SizedBox(
                    height: 20,
                  ),
                  ServiceInfoComponent(
                      title: 'Colaborador',
                      info: service.data.data.colaborator == null
                          ? 'Não informado'
                          : service.data.data.colaborator.name),
                  ServiceInfoComponent(
                      title: 'Status', info: service.data.data.status),
                  ServiceInfoComponent(
                      title: 'Garantia',
                      info:
                          '${service.data.data.warranty} ${service.data.data.warrantyUnity}'),
                  SizedBox(
                    height: 20,
                  ),
                  ServiceInfoComponent(
                      title: 'Valor',
                      info: Utils.formatMoney(service.data.data.value)),
                  ServiceInfoComponent(
                      title: 'Mão de Obra',
                      info: Utils.formatMoney(service.data.data.how)),
                  ServiceInfoComponent(
                      title: 'Desconto',
                      info: Utils.formatMoney(service.data.data.discount)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'O status do serviço será alterado para conlcuído',
                    style: Style.smallText,
                  )
                ],
              )),
          actions: <Widget>[
            MediumButtomComponent(title: 'CONCLUIR', function: function)
          ],
        );
      },
    );
  }

  static void requestAmount(String title, String message, Function function,
      String buttonTitle, TextEditingController controller, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: Style.dialogTitle),
          content: Container(
            height: 180,
            child: Center(
              child: MainTextFieldComponent(
                  controller: controller,
                  icon: LineIcons.calculator,
                  hint: message),
            ),
          ),
          actions: <Widget>[
            SmallButtomComponent(title: buttonTitle, function: function)
          ],
        );
      },
    );
  }

  static void writeObservation(String title, String message, Function function,
      String buttonTitle, TextEditingController controller, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: Style.dialogTitle),
          content: Container(
            height: 200,
            child: Center(
              child: MainTextFieldComponent(
                controller: controller,
                icon: LineIcons.calculator,
                hint: message,
                maxlines: 3,
              ),
            ),
          ),
          actions: <Widget>[
            SmallButtomComponent(title: buttonTitle, function: function)
          ],
        );
      },
    );
  }

  static String getCurrentDate({int days = 0}) {
    DateTime date = DateTime.now().add(Duration(days: days));

    return formatDate(date);
  }

  static Color selectServiceColor(String status) {
    switch (status) {
      case 'iniciado':
        return Colors.blue;
        break;

      case 'espera':
        return Colors.orange;
        break;

      case 'concluido':
        return Colors.green;
        break;

      case 'cancelado':
        return Colors.red;
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
