import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';

class NewServiceView extends StatefulWidget {
  final NewService newService;
  NewServiceView({@required this.newService});
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServiceController _shopController = ServiceController();

  Client client;
  Colaborator colaborator;
  Vehicle vehicle;

  bool loading = false;
  bool loadingDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.plus,
              title: 'Novo Serviço',
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 450,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        client == null
                            ? ListTile(
                                leading: Icon(LineIcons.user),
                                title: Text('Cliente não informado'),
                                subtitle: Text('Cliente'),
                              )
                            : ListTile(
                                leading: Icon(LineIcons.user),
                                title: Text(client.name),
                                subtitle: Text('Cliente'),
                              ),
                        vehicle == null
                            ? ListTile(
                                leading: Icon(LineIcons.car),
                                title: Text('Veículo não informado'),
                                subtitle: Text('Veículo'),
                              )
                            : ListTile(
                                leading: Icon(LineIcons.car),
                                title: Text(vehicle.name),
                                subtitle: Text('Veículo'),
                              ),
                        colaborator == null
                            ? ListTile(
                                leading: Icon(LineIcons.user),
                                title:
                                    Text('Colaborador ainda não selecionado'),
                                subtitle: Text('Colaborador'),
                              )
                            : ListTile(
                                leading: Icon(LineIcons.user),
                                title: Text(colaborator.name),
                                subtitle: Text('Colaborador'),
                              ),
                      ],
                    ),
                    Column(
                      children: [
                        loading
                            ? LoadingComponent()
                            : MainButtomComponent(
                                title: 'INICAR SERVIÇO',
                                function: createService),
                        SizedBox(
                          height: 10,
                        ),
                        loadingDelete
                            ? LoadingComponent(
                                delete: true,
                              )
                            : CancelButtomComponent(
                                title: 'CANCELAR',
                                function: () {
                                  Utils.confirmDialog(
                                      'Atenção',
                                      'Tem certeza que deseja cancelar o serviço',
                                      navigateToMain,
                                      'CANCELAR',
                                      context);
                                }),
                      ],
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

  createService() async {
    Map<String, dynamic> data;
    if (widget.newService.client != null &&
        widget.newService.colaborator != null &&
        widget.newService.vehicle != null) {
      data = {
        "client": client.id,
        "colaborator": colaborator.id,
        "car": vehicle.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id
      };
    } else if (widget.newService.client != null &&
        widget.newService.colaborator == null &&
        widget.newService.vehicle != null) {
      data = {
        "client": client.id,
        "car": vehicle.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id,
        "status": "espera"
      };
    } else if (widget.newService.client != null &&
        widget.newService.colaborator != null &&
        widget.newService.vehicle == null) {
      data = {
        "client": client.id,
        "colaborator": colaborator.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id
      };
    } else if (widget.newService.client != null &&
        widget.newService.colaborator == null &&
        widget.newService.vehicle == null) {
      data = {
        "client": client.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id,
        "status": "espera"
      };
    } else if (widget.newService.client == null &&
        widget.newService.colaborator == null &&
        widget.newService.vehicle == null) {
      data = {
        "shop": SessionVariables.userDataModel.data.data.shop.id,
        "status": "espera"
      };
    } else if (widget.newService.client == null &&
        widget.newService.colaborator != null &&
        widget.newService.vehicle == null) {
      data = {
        "colaborator": colaborator.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id,
      };
    }

    print(data);
    bool res = await _shopController.create(data, context, _scaffoldKey);

    if (res) {
      navigateToMain();
    }
  }

  navigateToMain() async {
    Navigator.pushNamed(context, '/main',
        arguments: SessionVariables.userDataModel.data.data.id);
  }

  setProperties() {
    client = widget.newService.client;
    colaborator = widget.newService.colaborator;
    vehicle = widget.newService.vehicle;
  }

  @override
  void initState() {
    super.initState();
    this.setProperties();
  }
}
