import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/car_model.dart';
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

  static Future<List<CarModel>> addCar(int cliente, String modelo, String placa) async {
    List<CarModel> cars = new List();
    String url = '${Urls.baseUrl}garantia/adicionar.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'cliente': cliente, 'modelo': modelo.toUpperCase(), 'placa': placa.toUpperCase()});

    try {
      var response = await dio.post(url, data: formData);

      json.decode(response.data).forEach((element) {
        cars.add(CarModel.fromJson(element));
      });
      return cars;
    } catch (e) {
      return null;
    }
  }
}
