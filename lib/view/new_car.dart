import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/car_model.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/service/car_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class NewCarView extends StatefulWidget {
  final String client;
  NewCarView({this.client});

  @override
  _NewCarViewState createState() => _NewCarViewState();
}

class _NewCarViewState extends State<NewCarView> {
  TextEditingController ctrModel = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CarModel> cars = new List();

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
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(LineIcons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
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
                            child: ListView.builder(
                                itemCount: cars.length,
                                itemBuilder: (context, index) {
                                  CarModel car = cars[index];
                                  return ListTile(
                                    title: Text(car.modelo, style: Style.carTitleText,),
                                    subtitle: Text(car.placa, style: Style.plateNameText,),
                                  );
                                }),
                          )
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

  addCar() async {
    List<CarModel> temp = await CarService.addCar(
        int.parse(widget.client), ctrModel.text, ctrPlate.text);

    if (temp != null) {
      Utils.showInSnackBar('Carro adicionado', Colors.green, _scaffoldKey);
      setState(() {
        cars = temp;
      });
    } else {
      Utils.showInSnackBar('Erro ao adionar carro', Colors.red, _scaffoldKey);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCars();
  }
}
