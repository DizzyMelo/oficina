import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/service_list_date_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ClientView extends StatefulWidget {
  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrSearchService = TextEditingController();
  //ctrSearchService
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone =
      MaskedTextController(mask: '(00) 00000-0000');

  TextEditingController ctrPhone2 =
      MaskedTextController(mask: '(00) 0000-0000');
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
              title: 'Clientes',
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
                                hint: 'Nome'),
                            MainTextFieldComponent(
                                controller: ctrCpf,
                                icon: LineIcons.user,
                                hint: 'CPF/CNPJ'),
                            MainTextFieldComponent(
                                controller: ctrPhone,
                                icon: LineIcons.phone,
                                hint: 'Celular'),
                            MainTextFieldComponent(
                                controller: ctrPhone2,
                                icon: LineIcons.phone,
                                hint: 'Telefone Fixo'),
                            MainTextFieldComponent(
                                controller: ctrEmail,
                                icon: LineIcons.envelope_o,
                                hint: 'Email'),
                            selectedClient != null &&
                                    selectedClient.carros.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        'Carros',
                                        style: Style.carTextTitle,
                                      )),
                                      Flexible(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: DropdownButton<String>(
                                                  items: selectedClient.carros
                                                      .map((carro) =>
                                                          DropdownMenuItem(
                                                              value: carro.id
                                                                  .toString(),
                                                              child: Text(
                                                                carro.modelo,
                                                                style: Style
                                                                    .carTextTitle,
                                                              )))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedCar = value;
                                                    });
                                                  },
                                                  value: _selectedCar,
                                                  isExpanded: true,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                  flex: 1,
                                                  child: IconButton(
                                                      icon:
                                                          Icon(LineIcons.plus),
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '/new_car',
                                                            arguments:
                                                                selectedClient
                                                                    .informacoes
                                                                    .clienteId);
                                                      }))
                                            ],
                                          ))
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            MainButtomComponent(
                                title: 'ADICIONAR CLIENTE', function: () {})
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
                              onSubmitted: searchClients,
                              style: Style.textField,
                              controller: ctrSearch,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    LineIcons.search,
                                    size: 20,
                                    color: Colors.grey[400],
                                  ),
                                  hintText: 'Buscar cliente...',
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
                                child: users == null
                                    ? Center(
                                        child: Text('Buscar cliente'),
                                      )
                                    : Scrollbar(
                                        child: ListView.builder(
                                          itemCount: users.data.users.length,
                                          itemBuilder: (context, index) {
                                            User user = users.data.users[index];
                                            return ListTile(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/edit_client',
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

  searchClients(String name) async {
    var res = await controller.searchByName(name, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        users = res;
      });
    }
  }

  bool validateInfo() {
    if (ctrName.text.isEmpty) {
      Utils.showInSnackBar(
          'Digite o nome do cliente', Colors.red, _scaffoldKey);
      return false;
    } else if (ctrPhone.text.isEmpty && ctrPhone2.text.isEmpty) {
      Utils.showInSnackBar(
          'Digite o número do celular ou telefone fixo do cliente',
          Colors.red,
          _scaffoldKey);
      return false;
    }

    return true;
  }

  createUser() async {
    if (!validateInfo()) return;

    String password = Utils.generateRandomPassword();
    Map<String, dynamic> data = {
      "name": ctrName.text,
      "email": ctrEmail.text,
      "password": password,
      "passwordConfirm": password,
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      "role": "cliente",
      "cpfcnpj": ctrCpf.text
    };

    await controller.create(data, context, _scaffoldKey);
  }

  void _addCardDialog(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Desaja adicionar um veículo ao cliente",
              style: Style.dialogTitle),
          content: Container(
              height: 180,
              child: Center(
                  child: Text(
                'Adione um veículo ao cliente',
                style: Style.dialogMessage,
              ))),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR", style: Style.closeButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("SIM", style: Style.okButton),
              onPressed: () {
                Navigator.pushNamed(context, '/new_car', arguments: id);
              },
            ),
          ],
        );
      },
    );
  }

  void _services() async {
    // flutter defined function
    await getServices();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Histórico de serviços - ${selectedClient.informacoes.clienteNome}",
            style: Style.dialogTitle,
          ),
          content: Container(
              height: 500,
              width: 700,
              child: services.isEmpty
                  ? Center(
                      child: Text(
                        'Cliente sem serviço registrado',
                        style: Style.notFoundTextTitle,
                      ),
                    )
                  : Column(
                      children: [
                        TextField(
                          controller: ctrSearchService,
                          style: Style.searchText,
                          decoration: InputDecoration(
                              hintText: 'Buscar...',
                              hintStyle: Style.searchText,
                              prefixIcon: Icon(Icons.search)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ServiceListDateComponent(services),
                        )
                      ],
                    )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "FECHAR",
                style: Style.closeButton,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  editClient() async {
    if (!validateInfo()) return;
  }

  getServices() async {}

  selectUser(User user) {
    ctrName.text = user.name;
    ctrCpf.text = user.cpfcnpj;
    ctrPhone.text = user.phone.length > 0 ? user.phone[0] : '';
    ctrPhone2.text = user.phone.length > 1 ? user.phone[1] : '';
    ctrEmail.text = user.email;
  }

  @override
  void initState() {
    super.initState();
    controller = UserController();
  }
}
