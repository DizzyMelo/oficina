import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/search_service_row_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/model/report_service_data_model.dart';
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
  ServiceController _serviceController = ServiceController();
  int results = 0;
  double totalValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.history,
              title: 'histórico de Serviços',
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 600,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: MainTextFieldComponent(
                              controller: ctrInitDate,
                              icon: LineIcons.calendar,
                              hint: 'Data Inicial'),
                        ),
                        Container(
                          width: 200,
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
                            title: 'BUSCAR SERVIÇOS', function: getReport),
                    Expanded(
                      child: report == null || report.results == 0
                          ? Center(
                              child: Text('Nenhum serviço a ser exibido'),
                            )
                          : ListView.builder(
                              itemCount: report.results,
                              itemBuilder: (context, index) {
                                Service service = report.data.services[index];
                                return SearchServiceRowComponent(
                                  service: service,
                                );
                              }),
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'resultados: ', style: Style.smallText),
                              TextSpan(
                                  text: '$results', style: Style.largeText),
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  validateDates() {
    try {
      DateTime.parse(Utils.formatDateReverse(ctrInitDate.text));
      DateTime.parse("${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00");

      return true;
    } catch (e) {
      Utils.showInSnackBar('Data inválida', Colors.red, _scaffoldKey);
      return false;
    }
  }

  getReport() async {
    if (!validateDates()) return;
    Map<String, dynamic> data = {
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "date": {
        "\$gte": Utils.formatDateReverse(ctrInitDate.text),
        "\$lte": "${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00"
      }
    };
    setState(() {
      loadingSearch = true;
    });
    ReportServiceDataModel res =
        await _serviceController.report(data, _scaffoldKey);

    setState(() {
      loadingSearch = false;
    });

    if (res != null) {
      double value = 0;

      res.data.services.forEach((element) {
        value += element.value;
      });
      setState(() {
        report = res;
        results = report.results;
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
