import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRequests {
  static login(cpfcnpj, password) async {
    String url = '${DotEnv().env['BASE_URL']}/users/login';
    print(url);
    Map<String, dynamic> data = {
      "cpfcnpj": cpfcnpj,
      "password": password,
    };
    print(data);

    //try {
    var res = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data));

    print(res.statusCode);

    if (res.statusCode == 200) {
      print('200');
      //return LoginModel.fromJson(json.decode(res.body));
    } else {
      print('diferente de 200');
      return null;
    }
    // } catch (e) {
    //   print('erro no try');
    //   return null;
    // }
  }
}
