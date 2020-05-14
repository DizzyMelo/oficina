import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ServiceView extends StatefulWidget {
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
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
                  height: 600,
                  width: 1000,
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
                            Flexible(flex: 1, child: Container()),
                            Flexible(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.grey[800]))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    color: Colors.red,
                                    child: Text('Cancelar'),
                                    onPressed: () {}),
                                SizedBox(width: 10),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    color: Colors.green,
                                    child: Row(
                                      children: [
                                        Icon(LineIcons.print),
                                        Text('Imprimir')
                                      ],
                                    ),
                                    onPressed: () {}),
                                SizedBox(width: 10),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    color: Colors.green,
                                    child: Text('Concluir'),
                                    onPressed: () {}),
                                SizedBox(width: 10),
                              ],
                            ),
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
