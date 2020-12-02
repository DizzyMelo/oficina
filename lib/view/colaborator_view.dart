import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/phone_textfield_component.dart';
import 'package:oficina/components/select_role_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ColaboratorView extends StatefulWidget {
  @override
  _ColaboratorViewState createState() => _ColaboratorViewState();
}

class _ColaboratorViewState extends State<ColaboratorView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrSearchService = TextEditingController();
  //ctrSearchService
  TextEditingController ctrName = TextEditingController();
  MaskedTextController ctrPhone = MaskedTextController(mask: '(00) 00000-0000');

  MaskedTextController ctrPhone2 = MaskedTextController(mask: '(00) 0000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrCpf = MaskedTextController(mask: '000.000.000-00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCar = '';

  List<ClientModel> clients = new List();
  SearchUserDataModel users;
  ClientModel selectedClient;

  List<ServiceModel> services = new List();

  UserController controller;

  IconData iconPhone = LineIcons.phone;
  IconData iconPhone2 = LineIcons.phone;

  bool loading = false;
  String role = 'mecanico';
  bool mecanic = true;
  bool atendant = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.user,
              title: 'Colaboradores',
            ),
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            MainTextFieldComponent(
                              controller: ctrName,
                              icon: LineIcons.user,
                              hint: 'Nome',
                              mandatory: true,
                            ),
                            MainTextFieldComponent(
                                controller: ctrCpf,
                                icon: LineIcons.user,
                                hint: 'CPF/CNPJ'),
                            PhoneTextFieldComponent(
                              controller: ctrPhone,
                              icon: iconPhone,
                              hint: 'Contato 1',
                              function: changeMaskPhone,
                              mandatory: true,
                            ),
                            PhoneTextFieldComponent(
                                controller: ctrPhone2,
                                icon: iconPhone2,
                                hint: 'Contato 2',
                                function: changeMaskPhone2),
                            MainTextFieldComponent(
                                controller: ctrEmail,
                                icon: LineIcons.envelope_o,
                                hint: 'Email'),
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
                            SizedBox(
                              height: 20,
                            ),
                            loading
                                ? LoadingComponent()
                                : MainButtomComponent(
                                    title: 'ADICIONAR COLABORADOR',
                                    function: createUser)
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              onSubmitted: searchColaborators,
                              style: Style.textField,
                              controller: ctrSearch,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    LineIcons.search,
                                    size: 20,
                                    color: Colors.grey[400],
                                  ),
                                  hintText: 'Buscar colaborador...',
                                  hintStyle: Style.textField,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[800],
                                  ))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: users == null ||
                                        users.data.users.length == 0
                                    ? Center(
                                        child: Text('Buscar colaborador'),
                                      )
                                    : Scrollbar(
                                        child: ListView.builder(
                                          itemCount: users.data.users.length,
                                          itemBuilder: (context, index) {
                                            User user = users.data.users[index];
                                            return ListTile(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/edit_user',
                                                    arguments: user);
                                              },
                                              title: Text(
                                                user.name,
                                                style: Style.clientNameText,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  searchColaborators(String name) async {
    var res =
        await controller.searchColaboratorByName(name, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  bool validateInfo() {
    if (ctrName.text.isEmpty) {
      Utils.showMessage('Informe o nome do cliente', context);
      return false;
    } else if (ctrPhone.text.isEmpty) {
      Utils.showMessage(
          'Informe ao menos o primeiro número de contato', context);
      return false;
    }

    return true;
  }

  createUser() async {
    if (!validateInfo()) return;

    String password = Utils.generateRandomPassword();
    Map<String, dynamic> data = Utils.validateUserData({
      "name": ctrName.text,
      "email": ctrEmail.text,
      "password": password,
      "passwordConfirm": password,
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "role": role,
      "cpfcnpj": Utils.removeSpecialCharacters(ctrCpf.text),
      "primaryphone": Utils.removeSpecialCharacters(ctrPhone.text),
      "secondaryphone": Utils.removeSpecialCharacters(ctrPhone2.text),
    });

    this.changeLoadingState();
    await controller.create(data, context, _scaffoldKey);
    this.changeLoadingState();
  }

  changeMaskPhone(String str) {
    if (str.isEmpty) {
      setState(() {
        iconPhone = LineIcons.phone;
      });
    }
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        ctrPhone.mask = '(00) 0000-0000';
        setState(() {
          iconPhone = LineIcons.phone;
        });
      } else {
        ctrPhone.mask = '(00) 00000-0000';
        setState(() {
          iconPhone = LineIcons.mobile;
        });
      }
    }
  }

  changeMaskPhone2(String str) {
    if (str.isEmpty) {
      setState(() {
        iconPhone2 = LineIcons.phone;
      });
    }
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        ctrPhone2.mask = '(00) 0000-0000';
        setState(() {
          iconPhone2 = LineIcons.phone;
        });
      } else {
        ctrPhone2.mask = '(00) 00000-0000';
        setState(() {
          iconPhone2 = LineIcons.mobile;
        });
      }
    }
  }

  changeLoadingState() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = UserController();
  }
}
