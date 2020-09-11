import 'package:flutter/material.dart';
import 'package:oficina/api_requests/vehicle_requests.dart';
import 'package:oficina/model/create_vehicle_data_model.dart';
import 'package:oficina/shared/utils.dart';

class VehicleController {
  VehicleRequests requests;

  VehicleController() {
    requests = VehicleRequests();
  }

  Future<CreateVehicleDataModel> create(data, context, scaffoldKey) async {
    CreateVehicleDataModel res = await requests.create(data);

    if (res != null) {
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar cadastrar o cliente', Colors.red, scaffoldKey);
      return null;
    }
  }
}
