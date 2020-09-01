import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRequests {
  login(email, password) async {
    String url = '${DotEnv().env['BASE_URL']}/users/login';
    Map<String, dynamic> data = {
      "email": email,
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
        //return LoginModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
