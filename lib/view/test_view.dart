import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:oficina/controller/service_controller.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {

  final serviceController = new ServiceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(builder: (_){
          return Text(serviceController.numeroDeClicks.toString());
        })
      ),
      floatingActionButton: FloatingActionButton(onPressed: serviceController.addClick, child: Icon(Icons.add, color: Colors.white,),),
    );
  }
}