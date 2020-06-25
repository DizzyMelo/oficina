import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/warranty_model.dart';
import 'package:oficina/shared/urls.dart';

class WarrantyService {
  static Future<List<WarrantyModel>> getWarranties() async {
    List<WarrantyModel> warranties = new List();
    String url = '${Urls.baseUrl}garantia/lista.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url);

      json.decode(response.data).forEach((element) {
        warranties.add(WarrantyModel.fromJson(element));
      });
      return warranties;
    } catch (e) {
      return null;
    }
  }

  static Future<WarrantyModel> addWarranty(servico, garantia ) async {
    
    String url = '${Urls.baseUrl}garantia/adicionar.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'servico': servico, 'garantia': garantia});

    try {
      var response = await dio.post(url, data: formData);

      return WarrantyModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }
}
