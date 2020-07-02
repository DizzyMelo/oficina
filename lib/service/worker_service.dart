import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/components/role_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/shared/urls.dart';

class WorkerService {
  static Future<List<WorkerModel>> getWorkers(String loja) async {
    List<WorkerModel> workers = new List();
    String url = '${Urls.baseUrl}colaborador/lista.php';
    Dio dio = new Dio();
    try{
      var response = await dio.get(url, 
      queryParameters: {
        'id': loja
      });

      json.decode(response.data).forEach((element) {
        workers.add(WorkerModel.fromJson(element));
      });
      
      return workers;
    }catch(e){
      return null;
    }
  }

  static Future<List<RoleModel>> getRoles(String loja) async {
    List<RoleModel> roles = new List();
    String url = '${Urls.baseUrl}colaborador/funcao.php';
    Dio dio = new Dio();
    try{
      var response = await dio.get(url, 
      queryParameters: {
        'id': loja
      });

      json.decode(response.data).forEach((element) {
        roles.add(RoleModel.fromJson(element));
      });
      
      return roles;
    }catch(e){
      return null;
    }
  }


  static Future<WorkerModel> addWorker(nome, telefone, endereco, loja, funcao, login) async {
    String url = '${Urls.baseUrl}colaborador/adicionar.php';
    FormData formData = new FormData.fromMap(
        {
          'loja': loja, 
          'nome': nome, 
          'telefone': telefone, 
          'endereco': endereco,
          'funcao': funcao,
          'login': login,
        });
    Dio dio = new Dio();
    try{
      var response = await dio.post(url, data: formData);
      return WorkerModel.fromJson(json.decode(response.data));
    }catch(e){
      return null;
    }
  }

  static Future<WorkerModel> editWorker(id, nome, telefone,funcao, login) async {
    String url = '${Urls.baseUrl}colaborador/editar.php';
    FormData formData = new FormData.fromMap(
        {
          'id': id, 
          'nome': nome, 
          'telefone': telefone,
          'funcao': funcao,
          'login': login,
        });
    Dio dio = new Dio();
    try{
      var response = await dio.post(url, data: formData);
      return WorkerModel.fromJson(json.decode(response.data));
    }catch(e){
      return null;
    }
  }

  static Future<WorkerModel> deleteWorker(colaborador) async {
    String url = '${Urls.baseUrl}colaborador/excluir.php';
    FormData formData = new FormData.fromMap(
        {
          'colaborador': colaborador
        });
    Dio dio = new Dio();
    try{
      var response = await dio.post(url, data: formData);
      return WorkerModel.fromJson(json.decode(response.data));
    }catch(e){
      return null;
    }
  }
}
