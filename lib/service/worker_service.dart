import 'dart:convert';

import 'package:dio/dio.dart';
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
}
