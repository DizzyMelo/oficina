import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/service/payment_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class FinishServiceView extends StatefulWidget {
  final ServiceModel service;

  FinishServiceView({this.service});
  @override
  _FinishServiceViewState createState() => _FinishServiceViewState();
}

class _FinishServiceViewState extends State<FinishServiceView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrPayment = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  Widget createTextField(
      String hint, TextEditingController controller, IconData icon, {Function function}) {
    return Column(
      children: [
        TextField(
          style: Style.textField,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: function != null ? IconButton(icon: Icon(LineIcons.plus), onPressed: function) : null,
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Colors.grey[400],
              ),
              hintText: hint,
              hintStyle: Style.textField,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Colors.grey[800],
              ))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(LineIcons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 500,
            width: 500,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'CONCLUIR SERVIÇO',
                    style: Style.mediumText,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey[500],
                  thickness: 2,
                ),

                createTextField('Pagamento', ctrPayment, LineIcons.money, function: makePayment)
              ],
            ),
          )
        ],
      ),
    );
  }

  makePayment() async {
    double valor = double.parse(ctrPayment.text.replaceAll('.', '').replaceAll(',', '.').replaceAll('R\$', '').trim());
    bool res = await PaymentService.addPayment(widget.service.idServico, 1, valor);

    if(res){
      Utils.showInSnackBar('Pagamento adicionado', Colors.green, _scaffoldKey);
    }else{
      Utils.showInSnackBar('Erro ao adicionar pagamento', Colors.red, _scaffoldKey);
    }
  }
}
