import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/search_textfield_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class SelectClientView extends StatefulWidget {
  @override
  _SelectClientViewState createState() => _SelectClientViewState();
}

class _SelectClientViewState extends State<SelectClientView> {
  TextEditingController ctrSearch = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SearchUserDataModel users;
  User client;
  UserController _userController;
  bool loading = false;
  Function function = null;
  NewService newService = NewService();

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
              title: 'Selecionar Cliente',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SearchTextFieldComponent(
                        controller: ctrSearch,
                        hint: 'Buscar cliente...',
                        function: searchClients),
                    loading
                        ? Expanded(
                            child: Center(
                              child: LoadingComponent(),
                            ),
                          )
                        : Expanded(
                            child: users == null
                                ? Center(
                                    child: Text(
                                        'Busque o cliente na barra superior'),
                                  )
                                : ListView.builder(
                                    itemCount: users.data.users.length,
                                    itemBuilder: (context, index) {
                                      User user = users.data.users[index];
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            client = user;
                                            newService.client = Client(
                                                id: user.id, name: user.name);
                                            function = () {
                                              Navigator.pushNamed(
                                                  context, '/select_car',
                                                  arguments: newService);
                                            };
                                          });
                                        },
                                        title: Text(user.name),
                                      );
                                    }),
                          ),
                    ListTile(
                      leading: Icon(
                        client == null ? LineIcons.warning : LineIcons.check,
                        color: client == null ? Colors.red : Style.primaryColor,
                      ),
                      title: Text(client == null
                          ? 'Cliente não selecionado'
                          : 'Cliente selecionado: ${client.name}'),
                      trailing: client == null
                          ? null
                          : IconButton(
                              icon: Icon(
                                LineIcons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  client = null;
                                  function = null;
                                  newService.client = null;
                                });
                              }),
                    ),
                    MainButtomComponent(title: 'CONTINUAR', function: function),
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/select_colaborator',
                              arguments: newService);
                        },
                        child: Text('Pular'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  searchClients(String name) async {
    if (name.length < 3) {
      Utils.showInSnackBar(
          'Digite pelo menos três caracteres', Colors.red, _scaffoldKey);
      return;
    }
    this.changeLodingState();
    SearchUserDataModel res =
        await _userController.searchUserByName(name, context, _scaffoldKey);
    this.changeLodingState();

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  changeLodingState() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
  }
}
