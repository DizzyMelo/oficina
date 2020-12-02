import 'package:flutter/material.dart';
import 'package:oficina/api_requests/service_requests.dart';
import 'package:oficina/model/create_service_data_model.dart';
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/model/report_service_data_model.dart';
import 'package:oficina/shared/utils.dart';

class ServiceController {
  ServiceRequests requests;

  ServiceController() {
    requests = ServiceRequests();
  }

  Future<bool> create(data, context, scaffoldKey) async {
    bool res = await requests.create(data);

    if (res != null) return res;
    Utils.showMessage('Erro ao iniciar o serviço', context);
    return false;
  }

  Future<ReportServiceDataModel> report(data, BuildContext context) async {
    ReportServiceDataModel res = await requests.report(data);

    if (res != null) return res;
    Utils.showMessage('Erro ao buscar serviços', context);
    return null;
  }

  Future<bool> edit(data, id, options, BuildContext context) async {
    bool res = await requests.edit(data, id, options);

    if (res) {
      Utils.showMessage('Serviço atualizado com sucesso', context,
          color: Colors.green);
      return res;
    }
    Utils.showMessage('Erro ao iniciar o serviço', context);
    return null;
  }

  Future<DetailServiceDataModel> getServiceDetails(
      id, BuildContext context) async {
    DetailServiceDataModel res = await requests.getServiceDetails(id);

    if (res != null) return res;
    Utils.showMessage('Serviço não encontrado', context);
    return null;
  }
}
