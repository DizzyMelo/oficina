import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:oficina/model/client_base_model.dart';
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


  static Future<ClientBaseModel> addClient(String loja, nome, t1, t2, cpf, email) async {
    String url = '${Urls.baseUrl}cliente/adicionar.php';
    FormData formData = new FormData.fromMap(
        {
          'loja': loja, 
          'nome': nome, 
          'telefone1': t1, 
          'telefone2': t2,
          'cpf': cpf,
          'email': email
        });
    Dio dio = new Dio();
    try{
      var response = await dio.post(url, data: formData);
      print(response.data);
      return ClientBaseModel.fromJson(json.decode(response.data));
    }catch(e){
      return null;
    }
  }
}
