import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/model/report_service_data_model.dart';

class ServiceRequests {
  Future<bool> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/services/';

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

  Future<bool> edit(data, id, options) async {
    String url = '${DotEnv().env['BASE_URL']}/services/$id/$options';

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

  Future<DetailServiceDataModel> getServiceDetails(id) async {
    String url = '${DotEnv().env['BASE_URL']}/services/$id';

    try {
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (res.statusCode == 200) {
        return DetailServiceDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ReportServiceDataModel> report(data) async {
    String url = '${DotEnv().env['BASE_URL']}/services/report';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 200) {
        return ReportServiceDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
