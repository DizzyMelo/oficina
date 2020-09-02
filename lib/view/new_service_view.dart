import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/medium_buttom_component.dart';
import 'package:oficina/components/search_textfield_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/shared/style.dart';

class NewServiceView extends StatefulWidget {
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<WorkerModel> workers = new List();
  List<ClientModel> clients = new List();
  ClientModel selectedClient;
  String _selectedCar = '';
  WorkerModel worker;

  SearchUserDataModel users;
  SearchUserDataModel colaborators;
  User client;
  User colaborator;

  UserController _userController;

  unselectAllClients() {
    clients.forEach((c) {
      c.selecionado = false;
    });
  }

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
                  children: <Widget>[
                    ListTile(
                      onTap: selectClient,
                      leading: Icon(LineIcons.user),
                      title: Text(
                          client == null ? 'Selecionar cliente' : client.name),
                      trailing: Icon(LineIcons.plus),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(LineIcons.car),
                      title: Text('Selecionar veículo'),
                      trailing: Icon(LineIcons.plus),
                    ),
                    ListTile(
                      onTap: selectColaborator,
                      leading: Icon(LineIcons.user),
                      title: Text(colaborator == null
                          ? 'Selecionar colaborador'
                          : colaborator.name),
                      trailing: Icon(LineIcons.plus),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MainButtomComponent(title: 'INICAR', function: () {})
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getColaborators() async {
    SearchUserDataModel res = await _userController.getColaborators(
        '5f4d4e7deb1bcc09ebe4b8b4', context, _scaffoldKey);

    if (res != null) {
      setState(() {
        colaborators = res;
      });
    }
  }

  addService(cliente, carro, mecanico, loja) async {}

  searchClients(String name) async {
    SearchUserDataModel res =
        await _userController.searchByName(name, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  void selectColaborator() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Selecionar Colaborador",
                  style: Style.dialogTitle,
                ),
                Text(
                  colaborator == null
                      ? "Colaborador não selecionado"
                      : colaborator.name,
                  style: Style.dialogSubtitle,
                ),
              ],
            ),
            content: Container(
              height: 400,
              width: 400,
              child: ListView.builder(
                  itemCount: colaborators.data.users.length,
                  itemBuilder: (context, index) {
                    User user = colaborators.data.users[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          colaborator = user;
                        });
                      },
                      title: Text(user.name),
                      subtitle: Text(user.role),
                    );
                  }),
            ),
            actions: <Widget>[
              MediumButtomComponent(
                  title: 'SELECIONAR',
                  function: () {
                    Navigator.pop(context, colaborator);
                  })
            ],
          );
        });
      },
    );
  }

  void selectClient() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Selecionar Cliente",
                  style: Style.dialogTitle,
                ),
                Text(
                  client == null ? "Cliente não selecionado" : client.name,
                  style: Style.dialogSubtitle,
                ),
              ],
            ),
            content: Container(
                height: 400,
                width: 400,
                child: Column(
                  children: [
                    SearchTextFieldComponent(
                      controller: ctrSearch,
                      hint: 'Buscar cliente...',
                      function: (name) async {
                        print('function called');
                        SearchUserDataModel res = await _userController
                            .searchByName(name, context, _scaffoldKey);

                        if (res != null) {
                          setState(() {
                            users = res;
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: users == null
                          ? Center(
                              child: Text('Buscar cliente'),
                            )
                          : ListView.builder(
                              itemCount: users.data.users.length,
                              itemBuilder: (context, index) {
                                User user = users.data.users[index];
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      client = user;
                                    });
                                  },
                                  title: Text(user.name),
                                  subtitle: Text(user.role),
                                );
                              }),
                    )
                  ],
                )),
            actions: <Widget>[
              MediumButtomComponent(
                  title: 'SELECIONAR',
                  function: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    this.getColaborators();
  }
}
