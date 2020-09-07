import 'package:flutter/material.dart';
import 'package:oficina/api_requests/user_requests.dart';
import 'package:oficina/model/create_user_data_model.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
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

  Future edit(data, id, delete, context, scaffoldKey) async {
    CreateUserDataModel res = await requests.edit(data, id);

    if (res != null) {
      Utils.showInSnackBar(
          'Cliente editado com sucesso', Colors.green, scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar editar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future searchUserByName(name, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.searchByName(name);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future searchColaboratorByName(name, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.searchColaborators(
        name, SessionVariables.userDataModel.data.data.shop.id);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future getColaborators(shop, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.getColaborators(shop);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future getUserInformation(id, context, scaffoldKey) async {
    GetUserDataModel res = await requests.getUserInformation(id);

    SessionVariables.userDataModel = res;

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
    }
  }

  Future getVehicles(userId, context, scaffoldKey) async {
    VehicleDataModel res = await requests.getUserVehicles(userId);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Nenhum veículo encontrado', Colors.red, scaffoldKey);
    }
  }
}
