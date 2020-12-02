import 'package:flutter/material.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/user_model.dart';

class SessionVariables {
  static UserModel userModel;
  static String token;
  static String userId;
  static GetUserDataModel userDataModel;
}

class Vehicle {
  String id;
  String name;

  Vehicle({@required this.id, @required this.name});
}

class Client {
  String id;
  String name;

  Client({@required this.id, @required this.name});
}

class Colaborator {
  String id;
  String name;

  Colaborator({@required this.id, @required this.name});
}

class NewService {
  Vehicle vehicle;
  Client client;
  Colaborator colaborator;

  NewService({this.client, this.vehicle, this.colaborator});
}
