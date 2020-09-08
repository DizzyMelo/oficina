import 'package:flutter/material.dart';
import 'package:oficina/api_requests/service_requests.dart';
import 'package:oficina/model/create_service_data_model.dart';
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/shared/utils.dart';

class ServiceController {
  ServiceRequests requests;

  ServiceController() {
    requests = ServiceRequests();
  }

  Future<CreateServiceDataModel> create(data, context, scaffoldKey) async {
    CreateServiceDataModel res = await requests.create(data);

    if (res != null) return res;
    Utils.showInSnackBar('Erro ao iniciar o serviço', Colors.red, scaffoldKey);
    return null;
  }

  Future<bool> edit(data, id, scaffoldKey) async {
    bool res = await requests.edit(data, id);

    if (res) {
      Utils.showInSnackBar(
          'Serviço atualizado com sucesso', Colors.green, scaffoldKey);
      return res;
    }
    Utils.showInSnackBar('Erro ao iniciar o serviço', Colors.red, scaffoldKey);
    return null;
  }

  Future<DetailServiceDataModel> getServiceDetails(id, scaffoldKey) async {
    DetailServiceDataModel res = await requests.getServiceDetails(id);

    if (res != null) return res;
    Utils.showInSnackBar('Serviço não encontrado', Colors.red, scaffoldKey);
    return null;
  }
}
