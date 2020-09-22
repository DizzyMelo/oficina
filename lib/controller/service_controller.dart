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
    Utils.showInSnackBar('Erro ao iniciar o serviço', Colors.red, scaffoldKey);
    return false;
  }

  Future<ReportServiceDataModel> report(data, scaffoldKey) async {
    ReportServiceDataModel res = await requests.report(data);

    if (res != null) return res;
    Utils.showInSnackBar('Erro ao buscar serviços', Colors.red, scaffoldKey);
    return null;
  }

  Future<bool> edit(data, id, options, scaffoldKey) async {
    bool res = await requests.edit(data, id, options);

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
