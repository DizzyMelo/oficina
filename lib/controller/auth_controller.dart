import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oficina/api_requests/auth_requests.dart';
import 'package:oficina/model/login_data_model.dart';
import 'package:oficina/shared/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  AuthRequests requests;

  AuthController() {
    requests = AuthRequests();
  }

  Future login(cpfcnpj, password, context, scaffoldKey) async {
    LoginDataModel l = await requests.login(cpfcnpj, password);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', l.token);
    Map<String, dynamic> decodedToken = JwtDecoder.decode(l.token);

    String userId = decodedToken['id'];

    if (l != null) {
      Navigator.pushNamed(context, '/main', arguments: userId);
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar realizar o login', Colors.red, scaffoldKey);
    }
  }
}
