import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/create_product_service_data_model.dart';

class ProductServiceRequests {
  Future<CreateProductServiceDataModel> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/services-products/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 201) {
        return CreateProductServiceDataModel.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete(id) async {
    String url = '${DotEnv().env['BASE_URL']}/services-products/$id';

    try {
      var res = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
