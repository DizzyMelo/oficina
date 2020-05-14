import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MainView extends StatefulWidget {
  final String data;

  MainView({this.data});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(LineIcons.close), onPressed: () => Navigator.pop(context)),
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    //width: screen.width * 0.3,
                    height: screen.height,
                    color: Colors.pink,
                  ),
                ),
                Flexible(
                    flex: 7,
                    child: Container(
                      //width: screen.width * 0.7,
                      height: screen.height,
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/service'),
                              title: Text("Nome do cliente"),
                              subtitle: Text("carro - telefone"),
                            );
                          }),
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }
}
