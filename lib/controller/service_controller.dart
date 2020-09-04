import 'package:flutter/material.dart';
import 'package:oficina/api_requests/service_requests.dart';
import 'package:oficina/model/create_service_data_model.dart';
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
}
