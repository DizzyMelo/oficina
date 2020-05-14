import 'package:dio/dio.dart';

class UserService {
  static login(String user, String pass) async {

    String url = 'http://oficinanamao.com.br/api/usuario/login.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "login": user,
      "senha": pass,
    });
    var response = await dio.post(url, data: formData);
    print(response.data);
  }
}
