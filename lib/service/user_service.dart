import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/shared/urls.dart';

class UserService {
  static Future<UserModel> login(String user, String pass) async {

    String url = '${Urls.baseUrl}usuario/login.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "login": user,
      "senha": pass,
    });
    try{
      var response = await dio.post(url, data: formData);
      return UserModel.fromJson(json.decode(response.data));
    }catch(e){
      return null;
    }
  }
}
