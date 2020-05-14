import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/shared/print.dart';
import 'package:oficina/shared/style.dart';

class ServiceView extends StatefulWidget {
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  TextEditingController ctrSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(LineIcons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
            Center(
              child: Container(
                  height: 700,
                  width: 1000,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius:
                            2.0, // has the effect of softening the shadow
                        spreadRadius:
                            2.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: ctrSearch,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey[400],
                                            ),
                                            hintText: "Buscar...",
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey[800],
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 400,
                                        child: ListView.builder(
                                            itemCount: 10,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text("produto"),
                                                trailing: Text("R\$100,00"),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                            Flexible(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.grey[800]))),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 100,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey[800]))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.red,
                                        child: Text('Cancelar',
                                            style: Style.serviceButton),
                                        onPressed: () {}),
                                    SizedBox(width: 10),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.green,
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.print,
                                              color: Colors.white,
                                            ),
                                            Text('Imprimir',
                                                style: Style.serviceButton)
                                          ],
                                        ),
                                        onPressed: () {
                                          Printer.print();
                                        }),
                                    SizedBox(width: 10),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.green,
                                        child: Text(
                                          'Concluir',
                                          style: Style.serviceButton,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
