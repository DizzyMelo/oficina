import 'package:flutter/material.dart';
import 'package:oficina/api_requests/payment_requests.dart';
import 'package:oficina/model/create_payment_data_model.dart';
import 'package:oficina/model/get_payments_data_model.dart';
import 'package:oficina/model/stats_data_model.dart';
import 'package:oficina/shared/utils.dart';

class PaymentController {
  PaymentRequests requests;

  PaymentController() {
    requests = PaymentRequests();
  }

  Future<bool> create(data, scaffoldKey) async {
    bool res = await requests.create(data);

    if (res) {
      Utils.showInSnackBar('Pagamento adicionado', Colors.green, scaffoldKey);
      return res;
    }

    Utils.showInSnackBar(
        'Erro ao adicionar pagamento', Colors.red, scaffoldKey);
    return false;
  }

  Future<StatsDataModel> stats(data, scaffoldKey) async {
    StatsDataModel res = await requests.stats(data);

    if (res != null) {
      return res;
    }

    Utils.showInSnackBar('Erro ao buscar dados', Colors.red, scaffoldKey);
    return null;
  }

  delete(id, scaffoldKey) async {
    bool res = await requests.delete(id);

    if (res) {
      Utils.showInSnackBar('Pagamento removido', Colors.green, scaffoldKey);
      return res;
    }

    Utils.showInSnackBar('Erro ao remover pagamento', Colors.red, scaffoldKey);
    return false;
  }

  Future<GetPaymentsDataModel> getPayments(id) async {
    return await requests.getPayments(id);
  }
}
