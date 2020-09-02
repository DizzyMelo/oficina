import 'package:flutter/material.dart';
import 'package:oficina/api_requests/user_requests.dart';
import 'package:oficina/model/create_user_data_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class UserController {
  UserRequests requests;

  UserController() {
    requests = UserRequests();
  }

  Future create(data, context, scaffoldKey) async {
    CreateUserDataModel res = await requests.create(data);

    if (res != null) {
      Utils.showInSnackBar(
          'Cliente cadastrado com sucesso', Colors.green, scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future searchByName(name, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.searchByName(name);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }
}
