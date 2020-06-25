import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/payment_format_model.dart';
import 'package:oficina/model/payment_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/warranty_model.dart';
import 'package:oficina/service/payment_service.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/service/warranty_service.dart';
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
  List<WarrantyModel> warranties = new List();
  double totalPaid = 0;

  PaymentFormatModel selectedFormat;
  WarrantyModel selectedWarranty;
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

  unsetWarranty() {
    warranties.forEach((element) {
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
    Size screen = MediaQuery.of(context).size;

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
                            Expanded(
                                child: ListView.builder(
                                    itemCount: paymentFormats.length,
                                    itemBuilder: (context, index) {
                                      PaymentFormatModel p =
                                          paymentFormats[index];
                                      return InkWell(
                                        onTap: () {
                                          this.unSetPaymentFormat();
                                          selectedFormat = p;
                                          setState(() {
                                            p.selected = !p.selected;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: p.selected ? 5 : 15,
                                              vertical: 5),
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
                                    })),
                            createTextField(
                                'Pagamento', ctrPayment, LineIcons.money,
                                function: makePayment),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LineIcons.money,
                                  color: totalPaid <
                                          double.parse(widget.service.valor)
                                      ? Colors.orange
                                      : Colors.green,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${Utils.formatMoney(totalPaid)} / ${Utils.formatMoney(double.parse(widget.service.valor))}',
                                  style: Style.totalValuePaid,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            // Divider(
                            //   color: Colors.grey[500],
                            //   thickness: 2,
                            // ),
                            Expanded(
                              child: payments.length > 0
                                  ? ListView.builder(
                                      itemExtent: 50,
                                      itemCount: payments.length,
                                      itemBuilder: (context, index) {
                                        PaymentModel p = payments[index];
                                        return ListTile(
                                          title: Text(
                                            Utils.formatMoney(
                                                double.parse(p.valor)),
                                            style: Style.itemValueText,
                                          ),
                                          subtitle: Text(
                                            Utils.formatDate(p.dataPagamento),
                                            style: Style.paymenyDateText,
                                          ),
                                          trailing: Text(
                                            p.formaId,
                                            style: Style.itemNameText,
                                          ),
                                        );
                                      })
                                  : Text(
                                      'Nenhum Pagamento Realizado',
                                      style: Style.warrantyText,
                                    ),
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(0),
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   border: Border.all(width: 1, color: Colors.orange)
                              // ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'GARANTIA',
                                        style: Style.mediumText,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        selectedWarranty == null
                                            ? 'Não selecionado'
                                            : '${selectedWarranty.garantia} meses',
                                        style: Style.warrantyText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Divider(
                                    //   color: Colors.grey[500],
                                    //   thickness: 2,
                                    // ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: warranties.length,
                                            itemBuilder: (context, index) {
                                              WarrantyModel p =
                                                  warranties[index];
                                              return InkWell(
                                                onTap: () {
                                                  addWarranty(p);
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          p.selected ? 5 : 15,
                                                      vertical: 5),
                                                  width: double.infinity,
                                                  height: 40,
                                                  color: Colors.blue,
                                                  child: Center(
                                                    child: p.loading
                                                        ? SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                      Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        : Text(
                                                            '${p.garantia} meses' ??
                                                                'no-data',
                                                            style: Style
                                                                .paymentFormatTitle,
                                                          ),
                                                  ),
                                                ),
                                              );
                                            }))
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ))
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 900,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(width: 0.5, color: Colors.grey[800]))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    color: Colors.green,
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.check,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Concluir Serviço', style: Style.serviceButton)
                      ],
                    ),
                    onPressed: conclude),
              ],
            ),
          ),
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
    double t = 0;
    List<PaymentModel> temp =
        await PaymentService.getPayments(int.parse(widget.service.idServico));

    if (temp != null) {
      temp.forEach((element) {
        t += double.parse(element.valor);
      });
      setState(() {
        payments = temp;
        totalPaid = t;
      });
    }
  }

  getWarranties() async {
    List<WarrantyModel> temp = await WarrantyService.getWarranties();

    if (temp != null) {
      setState(() {
        warranties = temp;
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

    if (format == 0) {
      Utils.showInSnackBar(
          'Selecione a forma de pagamento!', Colors.red, _scaffoldKey);
      return;
    }

    if (valor == 0) {
      Utils.showInSnackBar(
          'O valor deve ser maior que 0!', Colors.red, _scaffoldKey);
      return;
    }

    if (selectedFormat == null) {
      Utils.showInSnackBar(
          'Selecione a forma de pagamento!', Colors.red, _scaffoldKey);
      return;
    }

    List<PaymentModel> res = await PaymentService.addPayment(
        widget.service.idServico, int.parse(selectedFormat.id), valor);

    if (res != null) {
      double t = 0;
      Utils.showInSnackBar('Pagamento adicionado', Colors.green, _scaffoldKey);

      setState(() {
        res.forEach((element) {
          t += double.parse(element.valor);
        });

        setState(() {
          payments = res;
          totalPaid = t;
        });
      });
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar pagamento', Colors.red, _scaffoldKey);
    }
  }

  addWarranty(WarrantyModel w) async {
    this.unsetWarranty();
    selectedWarranty = w;
    setState(() {
      w.loading = true;
    });

    WarrantyModel m =
        await WarrantyService.addWarranty(widget.service.idServico, w.id);

    setState(() {
      w.loading = false;
    });

    if (m != null) {
      selectedWarranty = w;
      setState(() {
        w.selected = true;
      });
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar garantia', Colors.red, _scaffoldKey);
    }
  }

  conclude() async {
    bool res = await ServiceService.conclude(widget.service.idServico, 4);

    if (res) {
      Utils.showInSnackBar('Serviço concluído!', Colors.green, _scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao concluir serviço!', Colors.red, _scaffoldKey);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPaymentFormats();
    this.getPayments();
    this.getWarranties();
  }
}
