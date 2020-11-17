import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:oficina/model/create_user_data_model.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/model/vehicle_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:path/path.dart' as path;

class UserRequests {
  Future<CreateUserDataModel> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/users/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer ${SessionVariables.token}'
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

  Future<bool> edit(data, id, List<int> image, String fileName) async {
    String url = '${DotEnv().env['BASE_URL']}/users/$id';

    var request = new http.MultipartRequest("PATCH", Uri.parse(url));

    if (data['name'] != null) {
      request.fields['name'] = data['name'];
    }

    if (data['email'] != null) {
      request.fields['email'] = data['email'];
    }

    if (data['cpfcnpj'] != null) {
      request.fields['cpfcnpj'] = data['cpfcnpj'];
    }

    if (data['primaryphone'] != null) {
      request.fields['primaryphone'] = data['primaryphone'];
    }

    if (data['secondaryphone'] != null) {
      request.fields['secondaryphone'] = data['secondaryphone'];
    }
    request.headers['Authorization'] = 'Bearer ${SessionVariables.token}';

    if (image != null)
      request.files.add(
        http.MultipartFile.fromBytes('photo', image,
            contentType: MediaType(
              'image',
              path.extension(fileName),
            ),
            filename: fileName),
      );

    http.StreamedResponse res = await request.send();

    if (res.statusCode == 200) return true;

    return false;
  }

  Future<SearchUserDataModel> searchByName(name) async {
    String url = '${DotEnv().env['BASE_URL']}/users/search/$name';

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer ${SessionVariables.token}'
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

  Future<SearchUserDataModel> searchColaborators(name, shop) async {
    String url = '${DotEnv().env['BASE_URL']}/users/colaborators/$name/$shop';

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
