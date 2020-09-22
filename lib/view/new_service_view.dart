import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/model/create_service_data_model.dart' as service;
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewServiceView extends StatefulWidget {
  final List<dynamic> args;
  NewServiceView({@required this.args});
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServiceController _shopController = ServiceController();

  User client;
  User colaborator;
  Car vehicle;

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
                        ListTile(
                          leading: Icon(LineIcons.user),
                          title: Text(client.name),
                          subtitle: Text('Cliente'),
                        ),
                        ListTile(
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
    if (widget.args.length >= 3) {
      data = {
        "client": client.id,
        "colaborator": colaborator.id,
        "car": vehicle.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id
      };
    } else {
      data = {
        "client": client.id,
        "car": vehicle.id,
        "shop": SessionVariables.userDataModel.data.data.shop.id,
        "status": "espera"
      };
    }

    bool res = await _shopController.create(data, context, _scaffoldKey);

    if (res) {
      navigateToMain();
    }
  }

  navigateToMain() async {
    final prefs = await SharedPreferences.getInstance();
    Navigator.pushNamed(context, '/main',
        arguments: JwtDecoder.decode(prefs.getString('token'))['id']);
  }

  setProperties() {
    if (widget.args.length >= 3) {
      client = widget.args[0];
      vehicle = widget.args[1];
      colaborator = widget.args[2];
    } else {
      client = widget.args[0];
      vehicle = widget.args[1];
    }
  }

  @override
  void initState() {
    super.initState();
    this.setProperties();
  }
}
