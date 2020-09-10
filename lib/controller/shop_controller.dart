import 'package:flutter/material.dart';
import 'package:oficina/api_requests/shop_requests.dart';
import 'package:oficina/model/get_services_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';

class ShopController {
  ShopRequests requests;

  ShopController() {
    requests = ShopRequests();
  }

  Future<GetServiceDataModel> getServices(scaffoldKey) async {
    GetServiceDataModel res = await requests
        .getServices(SessionVariables.userDataModel.data.data.shop.id);

    if (res != null) return res;
    Utils.showInSnackBar('Nenhum serviço encontrado', Colors.red, scaffoldKey);
    return null;
  }

  Future<bool> edit(data, scaffoldKey) async {
    bool res = await requests.edit(
        data, SessionVariables.userDataModel.data.data.shop.id);

    if (res) {
      Utils.showInSnackBar(
          'Informações salvas com sucesso', Colors.green, scaffoldKey);
      return res;
    }
    Utils.showInSnackBar(
        'Erro ao atualizar as informações', Colors.red, scaffoldKey);
    return false;
  }
}
