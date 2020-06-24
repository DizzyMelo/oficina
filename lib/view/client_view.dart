import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/service/client_service.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ClientView extends StatefulWidget {
  @override
  _ClientViewState createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCar = '';

  List<ClientModel> clients = new List();
  ClientModel selectedClient;

  List<ServiceModel> services = new List();

  unselectAllClients() {
    clients.forEach((c) {
      c.selecionado = false;
    });
  }

  selectClient(ClientModel client) {
    ctrName.text = client.informacoes.clienteNome ?? '';
    ctrPhone.text = client.informacoes.telefone1 ?? '';
    ctrEmail.text = client.informacoes.email ?? '';
    //ctrCar.text = client.informacoes.carro ?? '';
    //ctrPlate.text = client.placa ?? '';
  }

  clearClient() {
    ctrName.text = '';
    ctrPhone.text = '';
    ctrEmail.text = '';
    ctrCar.text = '';
    ctrPlate.text = '';
  }

  Widget createTextField(
      String hint, TextEditingController controller, IconData icon) {
    return Column(
      children: [
        TextField(
          style: Style.textField,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Colors.grey[400],
              ),
              hintText: hint,
              hintStyle: Style.textField,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Colors.grey[800],
              ))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(LineIcons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            createTextField('Nome', ctrName, LineIcons.user),
                            createTextField(
                                'Telefone', ctrPhone, LineIcons.phone),
                            createTextField(
                                'Email', ctrEmail, LineIcons.envelope_o),
                            // createTextField('Carro', ctrCar, LineIcons.car),
                            // createTextField(
                            //     'Placa', ctrPlate, LineIcons.square_o),
                            selectedClient != null &&
                                    selectedClient.carros.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: Text('Carros')),
                                      Flexible(
                                          child: DropdownButton<String>(
                                        items: selectedClient.carros
                                            .map((carro) => DropdownMenuItem(
                                                value: carro.id.toString(),
                                                child: Text(carro.modelo)))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCar = value;
                                          });
                                        },
                                        value: _selectedCar,
                                        isExpanded: true,
                                      ))
                                    ],
                                  )
                                : Container(),
                            
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                selectedClient == null
                                    ? Container()
                                    : RaisedButton(
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.clock_o,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Histórico de Serviços",
                                              style: Style.serviceButton,
                                            ),
                                          ],
                                        ),
                                        onPressed: () async {
                                          _services();
                                        }),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          LineIcons.close,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cancelar",
                                          style: Style.serviceButton,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedClient = null;
                                        unselectAllClients();
                                        clearClient();
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          LineIcons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cadastrar Cliente",
                                          style: Style.serviceButton,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 3,
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
                                    child: Scrollbar(
                              child: ListView.builder(
                                itemCount: clients.length,
                                itemBuilder: (context, index) {
                                  ClientModel clientModel = clients[index];

                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        unselectAllClients();
                                        clientModel.selecionado =
                                            !clientModel.selecionado;
                                        _selectedCar =
                                            clientModel.carros.length > 0
                                                ? clientModel.carros.first.id
                                                : null;
                                        selectedClient = clientModel;
                                        if (clientModel.selecionado) {
                                          selectClient(clientModel);
                                        }
                                      });
                                    },
                                    title: Text(
                                      clientModel.informacoes.clienteNome,
                                      style: Style.clientNameText,
                                    ),
                                    subtitle: Text(
                                      'carro',
                                      //'${clientModel.carros.first.modelo} - ${clientModel.carros.first.placa}',
                                      style: Style.carText,
                                    ),
                                    trailing: Icon(clientModel.selecionado
                                        ? LineIcons.check
                                        : LineIcons.circle_o),
                                  );
                                },
                              ),
                            )))
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

  searchClients(String txt) async {
    if (txt.length < 3) {
      Utils.showInSnackBar(
          'Digite pelo menos 3 caracteres', Colors.red, _scaffoldKey);
      return;
    }
    List<ClientModel> tempClients = await ClientService.searchClients('1', txt);
    if (tempClients != null && tempClients.length > 0) {
      setState(() {
        clients = tempClients;
      });
    }
  }

  addClient() async {

  }

  void _services() async {
    // flutter defined function
    await getServices();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Histórico de serviços - ${selectedClient.informacoes.clienteNome}"),
          content: Container(
            height: 500,
            width: 600,
            child: services.isEmpty
                ? Text('Buscando Serviços')
                : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    ServiceModel service = services[index];
                    return ListTile(
                      title: Text(service.nomeCliente),
                      trailing: Text(service.dataInicio),
                    );
                  }),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ADICIONAR"),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  getServices() async {
    List<ServiceModel> s = await ServiceService.getServicesByClient(
        '1', selectedClient.informacoes.clienteId);

    if (s != null) {
      setState(() {
        services = s;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
