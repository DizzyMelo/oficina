import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/api_requests/auth_requests.dart';
import 'package:oficina/model/login_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  AuthRequests requests = AuthRequests();

  @observable
  bool loading = false;

  @observable
  bool obscure = true;

  @action
  changeObscure() => obscure = !obscure;

  bool validateInfo(String login, String pass, context) {
    if (login.isEmpty) {
      Utils.showMessage('Por favor, informe o seu CPF ou Telefone', context,
          color: Colors.red, icon: LineIcons.warning);
      return false;
    } else if (pass.isEmpty) {
      Utils.showMessage('Por favor, informe a senha', context,
          color: Colors.red, icon: LineIcons.warning);
      return false;
    }
    return true;
  }

  @action
  checkLoggedIn(context) async {
    await Future.delayed(Duration(milliseconds: 1500));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      return;
    }
    SessionVariables.token = token;
    SessionVariables.userId = JwtDecoder.decode(token)['id'];
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  @action
  Future login(cpfcnpj, password, context) async {
    cpfcnpj = Utils.removeSpecialCharacters(cpfcnpj);
    if (!validateInfo(cpfcnpj, password, context)) return;
    try {
      loading = true;
      LoginDataModel l = await requests.login(cpfcnpj, password);
      loading = false;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', l.token);
      SessionVariables.token = l.token;
      SessionVariables.userId = JwtDecoder.decode(l.token)['id'];

      if (l != null) {
        Navigator.pushNamed(context, '/main');
      } else {
        Utils.showMessage(
            'Usuário não encontrado, por favor corrija as informações e tente novamente',
            context,
            color: Colors.red,
            icon: LineIcons.warning);
      }
    } catch (e) {
      Utils.showMessage(
          'Usuário não encontrado, por favor corrija as informações e tente novamente',
          context,
          color: Colors.red,
          icon: LineIcons.warning);
    }
  }
}
