import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/service_info_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/shared/utils.dart';

class ManageFinishedServiceView extends StatefulWidget {
  final String serviceId;

  ManageFinishedServiceView({@required this.serviceId});
  @override
  _ManageFinishedServiceViewState createState() =>
      _ManageFinishedServiceViewState();
}

class _ManageFinishedServiceViewState extends State<ManageFinishedServiceView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DetailServiceDataModel service;

  ServiceController _serviceController = ServiceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.car,
              title: 'Serviço Concluído',
            ),
            service == null
                ? LoadingComponent()
                : Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 500,
                      width: 450,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Text('Informações do Gerais do Serviço'),
                          Divider(),
                          ServiceInfoComponent(
                              title: 'Cliente',
                              info: service.data.data.client == null
                                  ? ''
                                  : service.data.data.client.name),
                          ServiceInfoComponent(
                              title: 'Veículo',
                              info: service.data.data.car == null
                                  ? ''
                                  : service.data.data.car.name),
                          ServiceInfoComponent(
                              title: 'Data Início',
                              info:
                                  Utils.formatDateOnly(service.data.data.date)),
                          ServiceInfoComponent(
                              title: 'Data Final',
                              info: Utils.formatDateOnly(
                                  service.data.data.dateEnd)),
                          SizedBox(
                            height: 20,
                          ),
                          ServiceInfoComponent(
                              title: 'Colaborador',
                              info: service.data.data.colaborator.name),
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
                              title: 'Pagamento',
                              info:
                                  service.data.data.paid ? 'Pago' : 'Pendente'),
                          ServiceInfoComponent(
                              title: 'Valor',
                              info: Utils.formatMoney(service.data.data.value)),
                          ServiceInfoComponent(
                              title: 'Mão de Obra',
                              info: Utils.formatMoney(service.data.data.how)),
                          ServiceInfoComponent(
                              title: 'Desconto',
                              info: Utils.formatMoney(
                                  service.data.data.discount)),
                          Expanded(child: Container()),
                          MainButtomComponent(
                              title: 'REINICIAR SERVIÇO', function: () {})
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  getServiceDetails() async {
    DetailServiceDataModel res = await _serviceController.getServiceDetails(
        widget.serviceId, _scaffoldKey);

    if (res != null) {
      setState(() {
        service = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getServiceDetails();
  }
}
