import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/search_service_row_component.dart';
import 'package:oficina/controller/payment_controller.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/model/report_service_data_model.dart';
import 'package:oficina/model/stats_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MaskedTextController ctrInitDate = MaskedTextController(mask: '00/00/0000');
  MaskedTextController ctrFinalDate = MaskedTextController(mask: '00/00/0000');

  bool loadingSearch = false;

  ReportServiceDataModel report;
  StatsDataModel stats;

  ServiceController _serviceController = ServiceController();
  PaymentController _paymentController = PaymentController();
  int results = 0;
  double totalValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                AppBarComponent(
                  icon: LineIcons.history,
                  title: 'Histórico de Serviços',
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      height: 600,
                      width: 900,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 450,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 180,
                                      child: MainTextFieldComponent(
                                          controller: ctrInitDate,
                                          icon: LineIcons.calendar,
                                          hint: 'Data Inicial'),
                                    ),
                                    Container(
                                      width: 180,
                                      child: MainTextFieldComponent(
                                          controller: ctrFinalDate,
                                          icon: LineIcons.calendar,
                                          hint: 'Data Final'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                loadingSearch
                                    ? LoadingComponent()
                                    : MainButtomComponent(
                                        title: 'BUSCAR SERVIÇOS',
                                        function: getCompleteReport),
                                Expanded(
                                  child: report == null || report.results == 0
                                      ? Center(
                                          child: Text(
                                              'Nenhum serviço a ser exibido'),
                                        )
                                      : ListView.builder(
                                          itemCount: report.results,
                                          itemBuilder: (context, index) {
                                            Service service =
                                                report.data.services[index];
                                            return SearchServiceRowComponent(
                                              service: service,
                                            );
                                          }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 450,
                            child: Column(
                              children: [
                                Text('Estatíscas de pagamentos no período'),
                                Expanded(
                                  child: stats == null ||
                                          stats.data.stats.length == 0
                                      ? Center(
                                          child: Text(
                                              'Sem dados a serem exibidos'),
                                        )
                                      : ListView.builder(
                                          itemCount: stats.data.stats.length,
                                          itemBuilder: (context, index) {
                                            Stat stat = stats.data.stats[index];
                                            return ListTile(
                                              title: Text(stat.id.toUpperCase(),
                                                  style:
                                                      Style.mainClientNameText),
                                              subtitle: Text(
                                                'qtd: ${stat.counter} - med: ${Utils.formatMoney(stat.ave)} - max: ${Utils.formatMoney(stat.max)} - min: ${Utils.formatMoney(stat.min)}',
                                                style: Style.carNameText,
                                              ),
                                              trailing: Text(
                                                Utils.formatMoney(stat.total),
                                                style: Style.totalValueText,
                                              ),
                                            );
                                          }),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'pagamentos: ',
                                            style: Style.smallText),
                                        TextSpan(
                                            text: '$results',
                                            style: Style.largeText),
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Valor Total: ',
                                            style: Style.smallText),
                                        TextSpan(
                                            text: Utils.formatMoney(totalValue),
                                            style: Style.largeText),
                                      ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }

  validateDates() {
    try {
      DateTime.parse(Utils.formatDateReverse(ctrInitDate.text));
      DateTime.parse("${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00");

      return true;
    } catch (e) {
      Utils.showMessage(
        'Data inválida',
        context,
      );
      return false;
    }
  }

  getCompleteReport() async {
    if (!validateDates()) return;
    await getReport();
    await getStats();
  }

  getReport() async {
    Map<String, dynamic> data = {
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "status": "concluido",
      "date": {
        "\$gte": Utils.formatDateReverse(ctrInitDate.text),
        "\$lte": "${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00"
      }
    };
    setState(() {
      loadingSearch = true;
    });
    ReportServiceDataModel res = await _serviceController.report(data, context);

    setState(() {
      loadingSearch = false;
    });

    if (res != null) {
      setState(() {
        report = res;
      });
    }
  }

  getStats() async {
    Map<String, dynamic> data = {
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "date_init": "${Utils.formatDateReverse(ctrInitDate.text)} 00:00:00",
      "date_final": "${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00",
    };

    StatsDataModel res = await _paymentController.stats(data, context);

    if (res != null) {
      double value = 0;
      int counter = 0;

      res.data.stats.forEach((element) {
        value += element.total;
        counter += element.counter;
      });
      setState(() {
        stats = res;
        results = counter;
        totalValue = value;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ctrInitDate.text = Utils.getCurrentDate(days: -7);
    ctrFinalDate.text = Utils.getCurrentDate();
  }
}
