import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/user_base_model.dart';
import 'package:oficina/shared/urls.dart';

class UserService {
  static Future<UserBaseModel> login(String user, String pass, String token) async {
    String url = '${Urls.baseUrl}usuario/login.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "login": user,
      "senha": pass,
      "token": token,
    });
    try {
      var response = await dio.post(url, data: formData);
      print(response.data);
      return UserBaseModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<UserBaseModel> add(
      String first_name,
      String last_name,
      String email,
      String cpf,
      String store,
      String pass,
      int type,
      String telefone1,
      String telefone2) async {
    String url = '${Urls.baseUrl}usuario/adicionar.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "primeiro_nome": first_name,
      "ultimo_nome": last_name,
      "email": email,
      "cpf": cpf,
      "loja": store,
      "senha": pass,
      "tipo": type,
      'telefone1': telefone1,
      'telefone2': telefone2,
    });
    try {
      var response = await dio.post(url, data: formData);
      print(response.data);
      return UserBaseModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  Future<List> search() async {

  }

  Future<List> list() async {

  }
}
