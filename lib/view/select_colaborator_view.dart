import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/medium_buttom_component.dart';
import 'package:oficina/components/select_role_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class SelectColaboratorView extends StatefulWidget {
  final List<dynamic> args;

  SelectColaboratorView({@required this.args});
  @override
  _SelectColaboratorViewState createState() => _SelectColaboratorViewState();
}

class _SelectColaboratorViewState extends State<SelectColaboratorView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCpf = MaskedTextController(mask: '000.000.000-00');
  String role = 'mecanico';
  bool mecanic = true;
  bool atendant = false;
  Function function;

  SearchUserDataModel users;
  User colaborator;
  UserController _userController;
  bool loading = false;
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
              title: 'Selecionar Colaborador',
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    loading
                        ? Expanded(
                            child: Center(
                              child: LoadingComponent(),
                            ),
                          )
                        : Expanded(
                            child: users == null || users.data.users.length == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Busque o cliente na barra superior'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      MediumButtomComponent(
                                          title: 'ADICIONAR',
                                          function: addColaborator)
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: users.data.users.length,
                                    itemBuilder: (context, index) {
                                      User user = users.data.users[index];
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            colaborator = user;
                                            function = () {
                                              widget.args.add(user);

                                              Navigator.pushNamed(
                                                  context, '/new_service',
                                                  arguments: widget.args);
                                            };
                                          });
                                        },
                                        title: Text(user.name),
                                      );
                                    }),
                          ),
                    ListTile(
                      leading: Icon(
                        colaborator == null
                            ? LineIcons.warning
                            : LineIcons.check,
                        color: colaborator == null
                            ? Colors.red
                            : Style.primaryColor,
                      ),
                      title: Text(colaborator == null
                          ? 'Colaborador não selecionado'
                          : 'Colaborador selecionado: ${colaborator.name}'),
                      trailing: colaborator == null
                          ? null
                          : IconButton(
                              icon: Icon(
                                LineIcons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  colaborator = null;
                                  function = null;
                                });
                              }),
                    ),
                    MainButtomComponent(title: 'CONTINUAR', function: function)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getColaborators() async {
    this.changeLodingState();
    SearchUserDataModel res = await _userController.getColaborators(
        SessionVariables.userDataModel.data.data.shop.id,
        context,
        _scaffoldKey);
    this.changeLodingState();

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  createColaborator() async {
    Navigator.pop(context);

    String password = Utils.generateRandomPassword();

    Map<String, dynamic> data = {
      "name": ctrName.text,
      "email": ctrEmail.text,
      "password": password,
      "passwordConfirm": password,
      "shop": '5f4d4e7deb1bcc09ebe4b8b4',
      "role": role,
      "cpfcnpj": ctrCpf.text
    };

    if (data["email"].isEmpty) {
      data.remove("email");
    }

    await _userController.create(data, context, _scaffoldKey);

    this.getColaborators();

    print(data);
  }

  changeLodingState() {
    setState(() {
      loading = !loading;
    });
  }

  void addColaborator() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              "Adicionar Colaborador",
              style: Style.dialogTitle,
            ),
            content: Container(
              height: 200,
              width: 300,
              child: Column(
                children: [
                  MainTextFieldComponent(
                      controller: ctrName,
                      icon: LineIcons.user,
                      hint: 'Nome do Colaborador'),
                  MainTextFieldComponent(
                      controller: ctrEmail,
                      icon: LineIcons.envelope_o,
                      hint: 'Email'),
                  MainTextFieldComponent(
                      controller: ctrCpf,
                      icon: LineIcons.user,
                      hint: 'CPF/CNPJ'),
                  SizedBox(
                    height: 10,
                  ),
                  SelectRoleComponent(
                      title: 'Mecânico',
                      selected: mecanic,
                      function: () {
                        setState(() {
                          role = 'mecanico';
                          mecanic = true;
                          atendant = false;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  SelectRoleComponent(
                      title: 'Atendente',
                      selected: atendant,
                      function: () {
                        setState(() {
                          role = 'atendente';
                          mecanic = false;
                          atendant = true;
                        });
                      }),
                ],
              ),
            ),
            actions: <Widget>[
              MediumButtomComponent(
                  title: 'ADICIONAR', function: createColaborator)
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
