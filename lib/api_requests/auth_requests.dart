import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/login_data_model.dart';

class AuthRequests {
  Future<LoginDataModel> login(cpfcnpj, password) async {
    String url = '${DotEnv().env['BASE_URL']}/users/login';
    Map<String, dynamic> data = {
      "cpfcnpj": cpfcnpj,
      "password": password,
    };
    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 200) {
        return LoginDataModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
