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

  Future<GetServiceDataModel> getServices(BuildContext context) async {
    GetServiceDataModel res = await requests
        .getServices(SessionVariables.userDataModel.data.data.shop.id);

    if (res != null) return res;
    Utils.showMessage('Nenhum serviço encontrado', context);
    return null;
  }

  Future<bool> edit(data, BuildContext context) async {
    bool res = await requests.edit(
        data, SessionVariables.userDataModel.data.data.shop.id);

    if (res) {
      Utils.showMessage('Informações salvas com sucesso', context,
          color: Colors.green);
      return res;
    }
    Utils.showMessage('Erro ao atualizar as informações', context);
    return false;
  }
}
