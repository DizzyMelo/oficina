import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/urls.dart';

class PaymentService {
  static Future<List<ServiceModel>> getPayments(int service) async {
    List<ServiceModel> services = new List();
    String url = '${Urls.baseUrl}servico/lista.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url, queryParameters: {'loja': service});

      json.decode(response.data).forEach((element) {
        services.add(ServiceModel.fromJson(element));
      });
      return services;
      //return UserModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addPayment(servico, int forma, double valor) async {
    String url = '${Urls.baseUrl}pagamento/adicionar.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'forma': forma, 'servico': servico, 'valor': valor});

    var response = await dio.post(url, data: formData);
    
    if(response.data == 'true'){
      return true;  
    }
    return false;
  }
}
