import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/create_service_data_model.dart';

class ShopRequests {
  Future<CreateServiceDataModel> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/services/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 201) {
        return CreateServiceDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
