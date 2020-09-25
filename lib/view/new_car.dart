import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/controller/vehicle_controller.dart';
import 'package:oficina/model/create_vehicle_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class NewCarView extends StatefulWidget {
  final Client user;
  NewCarView({@required this.user});

  @override
  _NewCarViewState createState() => _NewCarViewState();
}

class _NewCarViewState extends State<NewCarView> {
  TextEditingController ctrModel = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VehicleDataModel vehicles;

  VehicleController _vehicleController = VehicleController();
  UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.car,
              title: 'Carros',
              function: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (route) => false,
                  arguments: SessionVariables.userDataModel.data.data.id,
                );
              },
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 500,
                width: 700,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              'ADICIONAR CARRO',
                              style: Style.clientTitle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MainTextFieldComponent(
                                controller: ctrModel,
                                icon: LineIcons.car,
                                hint: 'Modelo do carro'),
                            Text(
                              'MARCA MODELO ANO POTENCIA. EX.: FIAT UNO 2010 1.0',
                              style: Style.smallText,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MainTextFieldComponent(
                                controller: ctrPlate,
                                icon: LineIcons.square_o,
                                hint: 'Placa'),
                            SizedBox(
                              height: 20,
                            ),
                            MainButtomComponent(
                                title: 'ADICIONAR', function: addCar)
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: Style.containerSeparator,
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
                              child: vehicles == null ||
                                      vehicles.data.cars.length == 0
                                  ? Center(
                                      child:
                                          Text('Nenhum veículo a ser exibido'),
                                    )
                                  : Scrollbar(
                                      child: ListView.builder(
                                          itemCount: vehicles.data.cars.length,
                                          itemBuilder: (context, index) {
                                            Car car = vehicles.data.cars[index];
                                            return ListTile(
                                              onTap: () {
                                                NewService newService =
                                                    NewService();

                                                newService.client = widget.user;
                                                newService.vehicle = Vehicle(
                                                    id: car.id, name: car.name);
                                                Navigator.pushNamed(context,
                                                    '/select_colaborator',
                                                    arguments: newService);
                                              },
                                              title: Text(
                                                car.name,
                                                style: Style.carTitleText,
                                              ),
                                              subtitle: Text(
                                                car.plate,
                                                style: Style.plateNameText,
                                              ),
                                            );
                                          }),
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Selecione um veículo para iniciar um serviço')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getVehicles() async {
    VehicleDataModel res = await _userController.getVehicles(
        widget.user.id, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        vehicles = res;
      });
    }
  }

  bool validarInformacao() {
    if (ctrModel.text.isEmpty) {
      Utils.showInSnackBar(
          'Informe o modelo do carro. Recomendamos o seguinte formato: MARCA MODELO ANO POTENCIA. EX.: FIAT UNO 2010 1.0',
          Colors.red,
          _scaffoldKey);
      return false;
    }
    return true;
  }

  addCar() async {
    if (!validarInformacao()) return;

    Map<String, dynamic> data = {
      "name": ctrModel.text,
      "plate": ctrPlate.text,
      "user": widget.user.id
    };

    CreateVehicleDataModel res =
        await _vehicleController.create(data, context, _scaffoldKey);
    if (res != null) {
      this.getVehicles();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getVehicles();
  }
}
