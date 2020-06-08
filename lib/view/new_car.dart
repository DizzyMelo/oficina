import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/shared/style.dart';

class NewCarView extends StatefulWidget {
  final ClientModel client;
  NewCarView({this.client});

  @override
  _NewCarViewState createState() => _NewCarViewState();
}

class _NewCarViewState extends State<NewCarView> {
  TextEditingController ctrModel = TextEditingController();
  TextEditingController ctrPlate = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                width: 500,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      'ADICIONAR CARRO',
                      style: Style.clientTitle,
                    ),
                    SizedBox(height: 20,),
                    createTextField('Modelo', ctrModel, LineIcons.car),
                    createTextField('Placa', ctrPlate, LineIcons.square_o),
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
                        onPressed: () {}),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
