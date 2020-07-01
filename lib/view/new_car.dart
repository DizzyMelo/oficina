import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/worker_row_component.dart';
import 'package:oficina/model/car_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/car_service.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/service/worker_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class NewCarView extends StatefulWidget {
  final String client;
  final String clientName;
  NewCarView(this.clientName, {this.client});

  @override
  _NewCarViewState createState() => _NewCarViewState();
}

class _NewCarViewState extends State<NewCarView> {
  TextEditingController ctrModel = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CarModel> cars = new List();
  List<WorkerModel> workers = new List();

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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              AppBarComponent(icon: LineIcons.car, title: 'Carros',),
              Container(
                  padding: EdgeInsets.all(10),
                  height: 500,
                  width: 700,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Flexible(
                          child: Container(
                        child: Column(
                          children: [
                            Text(
                              'ADICIONAR CARRO',
                              style: Style.clientTitle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            createTextField('Modelo', ctrModel, LineIcons.car),
                            createTextField(
                                'Placa', ctrPlate, LineIcons.square_o),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          LineIcons.plus,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Adicionar",
                                          style: Style.serviceButton,
                                        ),
                                      ],
                                    ),
                                    onPressed: addCar),
                              ],
                            )
                          ],
                        ),
                      )),
                      Flexible(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'CARROS ADICIONADOS',
                                    style: Style.clientTitle,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: Scrollbar(
                                    child: ListView.builder(
                                        itemCount: cars.length,
                                        itemBuilder: (context, index) {
                                          CarModel car = cars[index];
                                          return ListTile(
                                            onTap: () {
                                              _initiateServicedDialog(
                                                  widget.client, car);
                                            },
                                            title: Text(
                                              car.modelo,
                                              style: Style.carTitleText,
                                            ),
                                            subtitle: Text(
                                              car.placa,
                                              style: Style.plateNameText,
                                            ),
                                          );
                                        }),
                                  ))
                                ],
                              )))
                    ],
                  ))
            ],
          ),
        ));
  }

  getCars() async {
    List<CarModel> temp = await CarService.getCars(int.parse(widget.client));

    if (temp != null) {
      setState(() {
        cars = temp;
      });
    }
  }

  bool validarInformacao() {
    if (ctrModel.text.isEmpty) {
      Utils.showInSnackBar(
          'Digite o modelo do carro', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  addCar() async {
    if (!validarInformacao()) return;
    List<CarModel> temp = await CarService.addCar(int.parse(widget.client),
        ctrModel.text, ctrPlate.text.isEmpty ? 'Não informado' : ctrPlate.text);

    if (temp != null) {
      _initiateServicedDialog(widget.client, temp.last);
      setState(() {
        cars = temp;
      });
    } else {
      Utils.showInSnackBar('Erro ao adionar carro', Colors.red, _scaffoldKey);
    }
  }

  void _initiateServicedDialog(String id, CarModel car) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        WorkerModel selectedWorker;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Gostaria de iniciar um serviço?",
                style: Style.dialogTitle),
            content: Container(
                height: 350,
                width: 500,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cliente: ${widget.clientName}'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Style.dialogSubtitle,
                        ),
                        Text(
                          selectedWorker == null
                              ? 'Selecione o mecânico'.toUpperCase()
                              : 'Mecânico: ${selectedWorker.nome}'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Style.dialogSubtitle,
                        )
                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Carro: ${car.modelo}'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Style.dialogSubtitle,
                        ),
                        Text('',
                          textAlign: TextAlign.center,
                          style: Style.dialogSubtitle,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey[800],
                    ),
                    Expanded(
                        child: Scrollbar(
                            child: ListView.builder(
                                itemExtent: 55,
                                itemCount: workers.length,
                                itemBuilder: (context, index) {
                                  WorkerModel worker = workers[index];
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedWorker = worker;
                                        });
                                      },
                                      child: WorkerRowComponent(worker));
                                })))
                  ],
                )),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("FECHAR", style: Style.closeButton),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              FlatButton(
                child: Text("INICIAR", style: Style.okButton),
                onPressed: () {
                  addService(widget.client, car.id, selectedWorker.id, '1');
                },
              ),
            ],
          );
        });
      },
    );
  }

  getWorkers() async {
    List<WorkerModel> w = await WorkerService.getWorkers('1');

    if (w != null) {
      setState(() {
        workers = w;
      });
    }
  }

  validate(){

  }

  addService(cliente, carro, mecanico, loja) async {
    ServiceModel temp = await ServiceService.addService(cliente, carro, mecanico, loja);
    if(temp != null){
      Navigator.pushNamed(context, '/service', arguments: temp);
    }else{
      Utils.showInSnackBar('Erro ao iniciar serviço', Colors.red, _scaffoldKey);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCars();
    this.getWorkers();
  }
}
