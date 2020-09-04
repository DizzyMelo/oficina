import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/create_user_data_model.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';

class UserRequests {
  Future<CreateUserDataModel> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/users/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 201) {
        return CreateUserDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<SearchUserDataModel> searchByName(name) async {
    String url = '${DotEnv().env['BASE_URL']}/users/search/$name';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 200) {
        return SearchUserDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<SearchUserDataModel> getColaborators(shop) async {
    String url = '${DotEnv().env['BASE_URL']}/users/colaborators/$shop';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 200) {
        return SearchUserDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<GetUserDataModel> getUserInformation(id) async {
    String url = '${DotEnv().env['BASE_URL']}/users/$id';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 200) {
        return GetUserDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<VehicleDataModel> getUserVehicles(id) async {
    String url = '${DotEnv().env['BASE_URL']}/users/$id/cars';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (res.statusCode == 200) {
        return VehicleDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
