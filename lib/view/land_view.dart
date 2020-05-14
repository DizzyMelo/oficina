import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class LandView extends StatefulWidget {
  @override
  _LandViewState createState() => _LandViewState();
}

class _LandViewState extends State<LandView> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        //backgroundColor: Style.primary,
        body: SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Login",
                    style: Style.loginButton,
                  ))),
          Row(
            children: [
              Container(
                height: screen.height,
                width: screen.width * 0.7,
                color: Colors.orange,
              ),
              Container(
                height: screen.height,
                width: screen.width * 0.3,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      )),
    ));
  }
}
