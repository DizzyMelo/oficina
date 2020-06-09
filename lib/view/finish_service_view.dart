import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/payment_format_model.dart';
import 'package:oficina/model/payment_model.dart';
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
  List<PaymentFormatModel> paymentFormats = new List();
  List<PaymentModel> payments = new List();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrPayment = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  unSetPaymentFormat() {
    paymentFormats.forEach((element) {
      setState(() {
        element.selected = false;
      });
    });
  }

  Widget createTextField(
      String hint, TextEditingController controller, IconData icon,
      {Function function}) {
    return Column(
      children: [
        TextField(
          style: Style.textField,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: function != null
                  ? IconButton(icon: Icon(LineIcons.plus), onPressed: function)
                  : null,
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
              width: 900,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'ADICIONAR PAGAMENTO',
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
                            createTextField(
                                'Pagamento', ctrPayment, LineIcons.money,
                                function: makePayment),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: paymentFormats.length,
                                    itemBuilder: (context, index) {
                                      PaymentFormatModel p =
                                          paymentFormats[index];
                                      return InkWell(
                                        onTap: () {
                                          this.unSetPaymentFormat();
                                          setState(() {
                                            p.selected = !p.selected;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          margin: EdgeInsets.symmetric( horizontal:
                                              p.selected ? 5 : 15, vertical: 5),
                                          width: double.infinity,
                                          height: 40,
                                          color: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              p.forma ?? 'no-data',
                                              style: Style.paymentFormatTitle,
                                            ),
                                          ),
                                        ),
                                      );
                                    }))
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'PAGAMENTOS',
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
                            Expanded(
                                child: ListView.builder(
                                    itemExtent: 50,
                                    itemCount: payments.length,
                                    itemBuilder: (context, index) {
                                      PaymentModel p =
                                          payments[index];
                                      return ListTile(
                                        title: Text(Utils.formatMoney(double.parse(p.valor)), style: Style.itemValueText,),
                                        subtitle: Text(Utils.formatDate(p.dataPagamento), style: Style.paymenyDateText,),
                                        trailing: Text(p.formaId, style: Style.itemNameText,),
                                      );
                                    }))
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.pink,
                      ))
                ],
              ))
        ],
      ),
    );
  }

  getPaymentFormats() async {
    List<PaymentFormatModel> temp = await PaymentService.getPaymentFormats();

    if (temp != null) {
      setState(() {
        paymentFormats = temp;
      });
    }
  }

  getPayments() async {
    List<PaymentModel> temp = await PaymentService.getPayments(int.parse(widget.service.idServico));
    
    if (temp != null) {
      setState(() {
        payments = temp;
      });
    }
  }

  makePayment() async {
    int format = 0;
    double valor = double.parse(ctrPayment.text
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .replaceAll('R\$', '')
        .trim());

    paymentFormats.forEach((element) {
      if (element.selected) {
        format = int.parse(element.id);
      }
    });

    if(format == 0) {
      Utils.showInSnackBar('Selecione a forma de pagamento!', Colors.red, _scaffoldKey);
      return;
    }
    
    if(valor == 0) {
      Utils.showInSnackBar('O valor deve ser maior que 0!', Colors.red, _scaffoldKey);
      return;
    }
    bool res =
        await PaymentService.addPayment(widget.service.idServico, 1, valor);

    if (res) {
      Utils.showInSnackBar('Pagamento adicionado', Colors.green, _scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar pagamento', Colors.red, _scaffoldKey);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPaymentFormats();
    this.getPayments();
  }
}
