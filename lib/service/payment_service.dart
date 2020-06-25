import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/payment_format_model.dart';
import 'package:oficina/model/payment_model.dart';
import 'package:oficina/shared/urls.dart';

class PaymentService {
  static Future<List<PaymentModel>> getPayments(int service) async {
    List<PaymentModel> services = new List();
    String url = '${Urls.baseUrl}pagamento/lista.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url, queryParameters: {'servico': service});

      json.decode(response.data).forEach((element) {
        services.add(PaymentModel.fromJson(element));
      });
      return services;
    } catch (e) {
      return null;
    }
  }

  static Future<List<PaymentFormatModel>> getPaymentFormats() async {
    List<PaymentFormatModel> services = new List();
    String url = '${Urls.baseUrl}pagamento/formas_pagamento.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url);

      json.decode(response.data).forEach((element) {
        services.add(PaymentFormatModel.fromJson(element));
      });
      return services;
      //return UserModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<List<PaymentModel>> addPayment(servico, int forma, double valor) async {
    List<PaymentModel> services = new List();
    String url = '${Urls.baseUrl}pagamento/adicionar.php';
    Dio dio = new Dio();

    Map<String, dynamic> map = {'forma': forma, 'servico': servico, 'valor': valor};

    FormData formData = new FormData.fromMap(map);
    print(map);
    var response = await dio.post(url, data: formData);
    
    try {
      json.decode(response.data).forEach((element) {
        services.add(PaymentModel.fromJson(element));
      });
      return services;
    } catch (e) {
      return null;
    }
  }
}
