import 'package:flutter/material.dart';
import 'package:oficina/api_requests/payment_requests.dart';
import 'package:oficina/model/get_payments_data_model.dart';
import 'package:oficina/model/stats_data_model.dart';
import 'package:oficina/shared/utils.dart';

class PaymentController {
  PaymentRequests requests;

  PaymentController() {
    requests = PaymentRequests();
  }

  Future<bool> create(data, BuildContext context) async {
    bool res = await requests.create(data);

    if (res) {
      Utils.showMessage('Pagamento adicionado', context, color: Colors.green);
      return res;
    }

    Utils.showMessage('Erro ao adicionar pagamento', context);
    return false;
  }

  Future<StatsDataModel> stats(data, BuildContext context) async {
    StatsDataModel res = await requests.stats(data);

    if (res != null) {
      return res;
    }

    Utils.showMessage('Erro ao buscar dados', context);
    return null;
  }

  delete(id, BuildContext context) async {
    bool res = await requests.delete(id);

    if (res) {
      Utils.showMessage('Pagamento removido', context, color: Colors.green);
      return res;
    }

    Utils.showMessage('Erro ao remover pagamento', context);
    return false;
  }

  Future<GetPaymentsDataModel> getPayments(id) async {
    return await requests.getPayments(id);
  }
}
