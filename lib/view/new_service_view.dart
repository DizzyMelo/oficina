import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';

class NewServiceView extends StatefulWidget {
  final List<dynamic> args;
  NewServiceView({@required this.args});
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserController _userController;

  User client;
  User colaborator;
  Car vehicle;

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
                        ListTile(
                          leading: Icon(LineIcons.user),
                          title: Text(colaborator.name),
                          subtitle: Text('Colaborador'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MainButtomComponent(
                            title: 'INICAR SERVIÇO', function: () {}),
                        SizedBox(
                          height: 10,
                        ),
                        CancelButtomComponent(
                            title: 'CANCELAR', function: () {}),
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

  addService(cliente, carro, mecanico, loja) async {}

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    client = widget.args[0];
    vehicle = widget.args[1];
    colaborator = widget.args[2];
  }
}
