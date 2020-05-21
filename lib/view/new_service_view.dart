import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/client_service.dart';
import 'package:oficina/service/worker_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class NewServiceView extends StatefulWidget {
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<WorkerModel> workers = new List();
  List<ClientModel> clients = new List();
  ClientModel selectedClient;
  WorkerModel worker;

  unselectAllClients() {
    clients.forEach((c) {
      c.selecionado = false;
    });
  }

  selectClient(ClientModel client) {
    ctrName.text = client.clienteNome ?? '';
    ctrPhone.text = client.telefone1 ?? '';
    ctrEmail.text = client.email ?? '';
    ctrCar.text = client.carro ?? '';
    ctrPlate.text = client.placa ?? '';
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
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            createTextField('Nome', ctrName, LineIcons.user),
                            createTextField(
                                'Telefone', ctrPhone, LineIcons.phone),
                            createTextField(
                                'Email', ctrEmail, LineIcons.envelope_o),
                            createTextField('Carro', ctrCar, LineIcons.car),
                            createTextField(
                                'Placa', ctrPlate, LineIcons.square_o),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  LineIcons.wrench,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  worker == null ? 'Colaborador' : worker.nome,
                                  style: Style.textField,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                selectedClient == null
                                    ? Container()
                                    : RaisedButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.user,
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
                                    onPressed: () {}),
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
                                          "Iniciar",
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
                      flex: 1,
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
                                        selectedClient = clientModel;
                                        if (clientModel.selecionado) {
                                          selectClient(clientModel);
                                        }
                                      });
                                    },
                                    title: Text(
                                      clientModel.clienteNome,
                                      style: Style.clientNameText,
                                    ),
                                    subtitle: Text(
                                      '${clientModel.carro} - ${clientModel.placa}',
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
                  Flexible(
                      flex: 1,
                      child: Container(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'COLABORADOR RESPONSÁVEL',
                            style: Style.selectWorkerTitle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.grey[500],
                            indent: 20,
                            endIndent: 20,
                          ),
                          Expanded(
                              child: Container(
                                  child: Scrollbar(
                            child: ListView.builder(
                              itemCount: workers.length,
                              itemBuilder: (context, index) {
                                WorkerModel workerModel = workers[index];
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      worker = workerModel;
                                    });
                                  },
                                  title: Text(
                                    workerModel.nome,
                                    style: Style.workerNameServiceText,
                                  ),
                                );
                              },
                            ),
                          )))
                        ],
                      ))),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  getWorkers() async {
    List<WorkerModel> wk = await WorkerService.getWorkers('1');

    if (wk != null && wk.length > 0) {
      setState(() {
        workers = wk;
      });
    }
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

  @override
  void initState() {
    super.initState();
    this.getWorkers();
  }
}
