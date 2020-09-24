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

  Future<bool> login(cpfcnpj, password, context, scaffoldKey) async {
    try {
      LoginDataModel l = await requests.login(cpfcnpj, password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', l.token);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(l.token);

      String userId = decodedToken['id'];

      if (l != null) {
        Navigator.pushNamed(context, '/main', arguments: userId);
      } else {
        Utils.showInSnackBar(
            'Usuário não encontrado!', Colors.red, scaffoldKey);
      }
    } catch (e) {
      Utils.showInSnackBar('Usuário não encontrado!', Colors.red, scaffoldKey);
    }
  }
}
