import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/get_payments_data_model.dart';

class PaymentRequests {
  Future<bool> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/payments/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(id) async {
    String url = '${DotEnv().env['BASE_URL']}/payments/$id';

    try {
      var res = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (res.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<GetPaymentsDataModel> getPayments(service) async {
    String url = '${DotEnv().env['BASE_URL']}/services/$service/payments';

    try {
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (res.statusCode == 200) {
        return GetPaymentsDataModel.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
