import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/select_role_component.dart';
import 'package:oficina/components/service_info_component.dart';
import 'package:oficina/controller/payment_controller.dart';
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/model/get_payments_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class PaymentView extends StatefulWidget {
  final DetailServiceDataModel service;

  PaymentView({@required this.service});
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrPaymentAmount = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  PaymentController _paymentController = PaymentController();
  GetPaymentsDataModel _payments;
  double containerHeight = 500;
  double containerWidth = 800;
  double totalPaid = 0;

  bool s1 = true;
  bool s2 = false;
  bool s3 = false;
  bool s4 = false;
  bool loadingAddPayment = false;
  bool loadingPayments = false;

  String paymentMethod = 'Dinheiro';
  String servicePaidMessage = '';

  String selectedPayment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.money,
              title: 'Pagamentos',
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: containerHeight,
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      height: containerHeight,
                      width: containerWidth / 2,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          MainTextFieldComponent(
                            controller: ctrPaymentAmount,
                            icon: LineIcons.money,
                            hint: 'Valor',
                          ),
                          SelectRoleComponent(
                              title: 'Dinheiro',
                              selected: s1,
                              function: () {
                                selectPaymentMethod(1);
                              }),
                          SelectRoleComponent(
                              title: 'Cartão de Crédito',
                              selected: s2,
                              function: () {
                                selectPaymentMethod(2);
                              }),
                          SelectRoleComponent(
                              title: 'Cartão de Débito',
                              selected: s3,
                              function: () {
                                selectPaymentMethod(3);
                              }),
                          SelectRoleComponent(
                              title: 'Transferência',
                              selected: s4,
                              function: () {
                                selectPaymentMethod(4);
                              }),
                          SizedBox(height: 20),
                          loadingAddPayment
                              ? LoadingComponent()
                              : MainButtomComponent(
                                  title: 'ADICIONAR', function: addPayment),
                          SizedBox(height: 30),
                          Divider(),
                          ServiceInfoComponent(
                              title: 'Valor Total',
                              info: Utils.formatMoney(
                                  widget.service.data.data.value)),
                          ServiceInfoComponent(
                              title: 'Valor Pago',
                              info: Utils.formatMoney(totalPaid)),
                          ServiceInfoComponent(
                              title: 'Valor a Pagar',
                              info: Utils.formatMoney(
                                  widget.service.data.data.value - totalPaid)),
                          Expanded(child: Container()),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              totalPaid >= widget.service.data.data.value
                                  ? Icon(
                                      LineIcons.check,
                                      color: Style.primaryColor,
                                    )
                                  : Icon(
                                      LineIcons.warning,
                                      color: Colors.red,
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(totalPaid >= widget.service.data.data.value
                                  ? 'Pagamento concluído'
                                  : 'Pagamento pendente')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: containerHeight,
                      width: containerWidth / 2,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 0.5, color: Colors.grey[800]),
                        ),
                      ),
                      child: _payments == null ||
                              _payments.data.payments.length == 0
                          ? Center(
                              child: Text('Nenhum pagamento a ser exibido'),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                  itemCount: _payments.data.payments.length,
                                  itemBuilder: (context, index) {
                                    Payment payment =
                                        _payments.data.payments[index];
                                    return ListTile(
                                      onLongPress: () {
                                        selectedPayment = payment.id;
                                        Utils.confirmDialog(
                                            'Excluir Pagamento',
                                            'Tem certeza que deseja excluir o pagamento',
                                            delete,
                                            'EXCLUIR',
                                            context);
                                      },
                                      title: Text(
                                        Utils.formatMoney(payment.value),
                                        style: Style.itemValueText,
                                      ),
                                      subtitle: Text(
                                        Utils.formatDate(payment.date),
                                        style: Style.paymenyDateText,
                                      ),
                                      trailing: Text(
                                        payment.method,
                                        style: Style.itemNameText,
                                      ),
                                    );
                                  }),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validatePayment() {
    double value = Utils.clearPrice(ctrPaymentAmount.text);
    if (value <= 0) {
      Utils.showInSnackBar(
          'O valor precisa ser maior que zero', Colors.red, _scaffoldKey);
      return false;
    }

    return true;
  }

  addPayment() async {
    if (!validatePayment()) return;
    double value = Utils.clearPrice(ctrPaymentAmount.text);
    Map<String, dynamic> data = {
      "value": value,
      "method": paymentMethod,
      "service": widget.service.data.data.id,
      "paid": totalPaid + value >= widget.service.data.data.value
    };
    setState(() {
      loadingAddPayment = !loadingAddPayment;
    });
    bool res = await _paymentController.create(data, _scaffoldKey);

    setState(() {
      loadingAddPayment = !loadingAddPayment;
    });
    if (res) {
      this.getPayments();
    }
  }

  delete() async {
    Navigator.pop(context);
    bool res = await _paymentController.delete(selectedPayment, _scaffoldKey);

    if (res) {
      this.getPayments();
    }
  }

  getPayments() async {
    GetPaymentsDataModel res =
        await _paymentController.getPayments(widget.service.data.data.id);

    if (res != null) {
      setState(() {
        totalPaid = 0;
        _payments = res;
        _payments.data.payments.forEach((element) {
          totalPaid += element.value;
        });
      });
    }
  }

  selectPaymentMethod(int opt) {
    setState(() {
      s1 = false;
      s2 = false;
      s3 = false;
      s4 = false;

      switch (opt) {
        case 1:
          s1 = true;
          paymentMethod = 'Dinheiro';
          break;
        case 2:
          s2 = true;
          paymentMethod = 'Cartão de Crédito';
          break;
        case 3:
          s3 = true;
          paymentMethod = 'Cartão de Débito';
          break;
        case 4:
          s4 = true;
          paymentMethod = 'Transferência';
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getPayments();
    print(widget.service.data.data.id);
  }
}
