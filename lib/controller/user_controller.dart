import 'package:flutter/material.dart';
import 'package:oficina/api_requests/user_requests.dart';
import 'package:oficina/model/create_user_data_model.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';

class UserController {
  UserRequests requests;

  UserController() {
    requests = UserRequests();
  }

  Future<CreateUserDataModel> create(data, context, scaffoldKey) async {
    CreateUserDataModel res = await requests.create(data);

    if (res != null) {
      Utils.showMessage('Usuário cadastrado com sucesso', context,
          color: Colors.green);
      return res;
    } else {
      Utils.showMessage('Erro ao tentar cadastrar o usuário', context);
      return null;
    }
  }

  Future edit(Map<String, dynamic> data, String id, List<int> image,
      String fileName, BuildContext context) async {
    bool res = await requests.edit(data, id, image, fileName);

    if (res) {
      Utils.showMessage('Cliente editado com sucesso', context,
          color: Colors.green);
    } else {
      Utils.showMessage('Erro ao tentar editar o cliente', context);
    }
  }

  Future searchUserByName(name, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.searchByName(name);

    if (res != null) {
      return res;
    } else {
      Utils.showMessage('Erro ao buscar usuário!', context);
    }
  }

  Future searchColaboratorByName(name, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.searchColaborators(
        name, SessionVariables.userDataModel.data.data.shop.id);

    if (res != null) {
      return res;
    } else {
      Utils.showMessage('Erro ao buscar o colaborador pelo nome', context);
    }
  }

  Future getColaborators(shop, context, scaffoldKey) async {
    SearchUserDataModel res = await requests.getColaborators(shop);

    if (res != null) {
      return res;
    } else {
      Utils.showMessage('Erro ao buscar colaborador', context);
    }
  }

  Future getUserInformation(id, context, scaffoldKey) async {
    GetUserDataModel res = await requests.getUserInformation(id);

    if (res != null) {
      SessionVariables.userDataModel = res;
      return res;
    } else {
      return null;
    }
  }

  Future<VehicleDataModel> getVehicles(userId, context, scaffoldKey) async {
    VehicleDataModel res = await requests.getUserVehicles(userId);

    if (res != null) {
      return res;
    } else {
      Utils.showMessage('Nenhum veículo encontrado', context);

      return null;
    }
  }
}
