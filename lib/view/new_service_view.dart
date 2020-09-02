import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
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
                    MainTextFieldComponent(
                        controller: ctrSearch,
                        icon: LineIcons.search,
                        hint: 'Buscar'),
                    SizedBox(
                      height: 30,
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

  getWorkers() async {
    List<WorkerModel> wk = await WorkerService.getWorkers('1');

    if (wk != null && wk.length > 0) {
      setState(() {
        workers = wk;
      });
    }
  }

  bool validateServiceInfo() {
    if (selectedClient == null) {
      Utils.showInSnackBar('Selecione o cliente', Colors.red, _scaffoldKey);
      return false;
    } else if (worker == null) {
      Utils.showInSnackBar('Selecione o colaborador', Colors.red, _scaffoldKey);
      return false;
    } else if (_selectedCar == null || _selectedCar.isEmpty) {
      Utils.showInSnackBar(
          'Selecione o carro do cliente', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  addService(cliente, carro, mecanico, loja) async {
    ServiceModel temp =
        await ServiceService.addService(cliente, carro, mecanico, loja);
    if (temp != null) {
      Navigator.pushNamed(context, '/service', arguments: temp);
    } else {
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
