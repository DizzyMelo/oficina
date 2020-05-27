import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/view/land_view.dart';
import 'package:oficina/view/login_view.dart';
import 'package:oficina/view/main_view.dart';
import 'package:oficina/view/new_service_view.dart';
import 'package:oficina/view/service_view.dart';
import 'package:oficina/view/stock_view.dart';
import 'package:oficina/view/worker_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oficina na Mão',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/main',
      onGenerateRoute: (RouteSettings settings) {
        var page;

        switch (settings.name) {
          case "/login":
            page = MaterialPageRoute(builder: (context) => LoginView());
            break;
          case "/main":
            UserModel user = UserModel.fromJson(json.decode('''{
                "id": "1",
                "nome": "felipe freitas de melo",
                "telefone": "(23)34645-7565",
                "endereco": "rua teste 123",
                "funcao_id": "1",
                "senha": "mo123",
                "token": "token",
                "loja_id": "1",
                "sts": "1",
                "login": "daniel.melo",
                "lojaNome": "ZN Radiadores"
              }'''));
            page = MaterialPageRoute(
                builder: (context) => MainView(user: user));
            break;
          case "/service":
            page = MaterialPageRoute(builder: (context) => ServiceView(serviceModel: settings.arguments,));
            break;
          case "/new_service":
            page = MaterialPageRoute(builder: (context) => NewServiceView());
            break;
          case "/stock":
            page = MaterialPageRoute(builder: (context) => StockView());
            break;
          case "/worker":
            page = MaterialPageRoute(builder: (context) => WorkerView());
            break;
        }

        return page;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => LoginView());
      },
    );
  }
}

/*
{
	"id": "1",
	"nome": "daniel freitas de melo",
	"telefone": "(23)34645-7565",
	"endereco": "rua teste 123",
	"funcao_id": "1",
	"senha": "mo123",
	"token": "token",
	"loja_id": "1",
	"sts": "1",
	"login": "daniel.melo",
	"lojaNome": "ZN Radiadores"
}

*/
