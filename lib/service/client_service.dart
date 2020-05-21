import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/client_model.dart';
import 'package:oficina/shared/urls.dart';

class ClientService {
  static Future<List<ClientModel>> searchClients(String loja, String busca) async {
    List<ClientModel> clients = new List();
    String url = '${Urls.baseUrl}cliente/busca.php';
    Dio dio = new Dio();
    try{
      var response = await dio.get(url, 
      queryParameters: {
        'loja': loja,
        'busca': busca,
      });

      json.decode(response.data).forEach((element) {
        clients.add(ClientModel.fromJson(element));
      });
      
      return clients;
    }catch(e){
      return null;
    }
  }
}
