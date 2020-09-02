import 'package:flutter/material.dart';
import 'package:oficina/api_requests/auth_requests.dart';
import 'package:oficina/model/login_data_model.dart';
import 'package:oficina/shared/utils.dart';

class AuthController {
  AuthRequests requests;

  AuthController() {
    requests = AuthRequests();
  }

  Future login(cpfcnpj, password, context, scaffoldKey) async {
    LoginDataModel l = await requests.login(cpfcnpj, password);

    if (l != null) {
      Navigator.pushNamed(context, '/main');
    } else {
      Utils.showInSnackBar(
          'Erro ao tentar realizar o login', Colors.red, scaffoldKey);
    }
  }
}
