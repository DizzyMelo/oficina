import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/client_service.dart';
import 'package:oficina/service/service_service.dart';
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
  String _selectedCar = '';
  WorkerModel worker;

  unselectAllClients() {
    clients.forEach((c) {
      c.selecionado = false;
    });
  }

  selectClient(ClientModel client) {
    ctrName.text = client.informacoes.clienteNome ?? '';
    ctrPhone.text = client.informacoes.telefone1 ?? '';
    ctrEmail.text = client.informacoes.email ?? '';
    //ctrCar.text = client.carro ?? '';
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
            AppBarComponent(icon: LineIcons.plus, title: 'Novo Serviço',),
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
                              height: 10,
                            ),

                            selectedClient != null &&
                                    selectedClient.carros.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: Text('Carros', style: Style.carTextTitle,)),
                                      Flexible(
                                          child: DropdownButton<String>(
                                        items: selectedClient.carros
                                            .map((carro) => DropdownMenuItem(
                                                value: carro.id.toString(),
                                                child: Text(carro.modelo, style: Style.carTextTitle,)))
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

                              SizedBox(height: 20,),
                            
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
                                              LineIcons.car,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Adicionar Carro",
                                              style: Style.serviceButton,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/new_car', arguments: selectedClient.informacoes.clienteId);
                                          // setState(() {
                                          //   selectedClient = null;
                                          //   unselectAllClients();
                                          //   clearClient();
                                          // });
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
                                      clearClient();
                                      unselectAllClients();
                                      setState(() {
                                        selectedClient = null;
                                        worker = null;
                                        _selectedCar = '';
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
                                          "Iniciar",
                                          style: Style.serviceButton,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      if(!validateServiceInfo()) return;
                                      addService(selectedClient.informacoes.clienteId, _selectedCar, worker.id, '1');
                                    }),
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
                                  suffixIcon: IconButton(icon: Icon(LineIcons.plus), onPressed: (){
                                    Navigator.pushNamed(context, '/client');
                                  }),
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
                                        _selectedCar =  clientModel.carros.length > 0 ? clientModel.carros.first.id : null;
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
                                      Utils.getCars(clientModel.carros),
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
                                  subtitle: Text(
                                    workerModel.funcao,
                                    style: Style.workerRoleSubtitle,
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

  bool validateServiceInfo(){
    if(selectedClient == null){
      Utils.showInSnackBar('Selecione o cliente', Colors.red, _scaffoldKey);
      return false;
    } else if(worker == null){
      Utils.showInSnackBar('Selecione o colaborador', Colors.red, _scaffoldKey);
      return false;
    } else if(_selectedCar == null || _selectedCar.isEmpty){
      Utils.showInSnackBar('Selecione o carro do cliente', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  addService(cliente, carro, mecanico, loja) async {
    ServiceModel temp = await ServiceService.addService(cliente, carro, mecanico, loja);
    if(temp != null){
      Navigator.pushNamed(context, '/service', arguments: temp);
    }else{
      Utils.showInSnackBar('Erro ao iniciar serviço', Colors.red, _scaffoldKey);
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
