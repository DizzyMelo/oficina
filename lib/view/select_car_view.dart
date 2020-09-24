import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/medium_buttom_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/controller/vehicle_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/style.dart';

class SelectCarView extends StatefulWidget {
  final User user;

  SelectCarView({@required this.user});
  @override
  _SelectCarViewState createState() => _SelectCarViewState();
}

class _SelectCarViewState extends State<SelectCarView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPlate = TextEditingController();

  UserController _userController;
  VehicleController _vehicleController;
  bool loading = false;
  Car vehicle;
  Function function = null;

  VehicleDataModel vehicles;
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
              title: 'Selecionar Veículo',
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
                child: loading
                    ? Center(
                        child: LoadingComponent(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          vehicles == null || vehicles.data.cars.length == 0
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Nenhum carro encontrado para este cliete'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      MediumButtomComponent(
                                          title: 'ADICIONAR',
                                          function: addVehicle)
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: vehicles.data.cars.length,
                                      itemBuilder: (context, index) {
                                        Car v = vehicles.data.cars[index];
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              vehicle = v;
                                              function = () {
                                                Navigator.pushNamed(context,
                                                    '/select_colaborator',
                                                    arguments: [
                                                      widget.user,
                                                      v
                                                    ]);
                                              };
                                            });
                                          },
                                          title: Text(v.name),
                                        );
                                      }),
                                ),
                          ListTile(
                            leading: Icon(
                              vehicle == null
                                  ? LineIcons.warning
                                  : LineIcons.check,
                              color: vehicle == null
                                  ? Colors.red
                                  : Style.primaryColor,
                            ),
                            title: Text(vehicle == null
                                ? 'Veículo não selecionado'
                                : 'Veículo selecionado: ${vehicle.name}'),
                            trailing: vehicle == null
                                ? null
                                : IconButton(
                                    icon: Icon(
                                      LineIcons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        vehicle = null;
                                        function = null;
                                      });
                                    }),
                          ),
                          MainButtomComponent(
                              title: 'CONTINUAR', function: function),
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/select_colaborator',
                                    arguments: [widget.user]);
                              },
                              child: Text('PULAR'))
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getVehicles() async {
    this.changeLodingState();
    VehicleDataModel res = await _userController.getVehicles(
        widget.user.id, context, _scaffoldKey);
    this.changeLodingState();

    if (res != null) {
      setState(() {
        vehicles = res;
      });
    }
  }

  createVehicle() async {
    Navigator.pop(context);
    this.changeLodingState();

    Map<String, dynamic> data = {
      "name": ctrName.text,
      "plate": ctrPlate.text,
      "user": widget.user.id
    };
    await _vehicleController.create(data, context, _scaffoldKey);
    this.changeLodingState();
    this.getVehicles();
  }

  changeLodingState() {
    setState(() {
      loading = !loading;
    });
  }

  void addVehicle() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Adicionar Veículo",
            style: Style.dialogTitle,
          ),
          content: Container(
              height: 130,
              width: 300,
              child: Column(
                children: [
                  MainTextFieldComponent(
                      controller: ctrName,
                      icon: LineIcons.car,
                      hint: 'Modelo do Veículo'),
                  MainTextFieldComponent(
                      controller: ctrPlate, icon: LineIcons.car, hint: 'Placa')
                ],
              )),
          actions: <Widget>[
            MediumButtomComponent(title: 'ADICIONAR', function: createVehicle)
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    _vehicleController = VehicleController();
    this.getVehicles();
  }
}
