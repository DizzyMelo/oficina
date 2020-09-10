import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/get_services_data_model.dart';

class ShopRequests {
  Future<GetServiceDataModel> getServices(id) async {
    String url = '${DotEnv().env['BASE_URL']}/shops/$id/services';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 200) {
        return GetServiceDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> edit(data, id) async {
    String url = '${DotEnv().env['BASE_URL']}/shops/$id';

    try {
      var res = await http.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
