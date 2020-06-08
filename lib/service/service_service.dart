import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/added_item_model.dart';
import 'package:oficina/model/item_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/shared/urls.dart';

class ServiceService {
  static Future<List<ServiceModel>> getServices(String store) async {
    List<ServiceModel> services = new List();
    String url = '${Urls.baseUrl}servico/lista.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url, queryParameters: {'loja': store});

      json.decode(response.data).forEach((element) {
        services.add(ServiceModel.fromJson(element));
      });
      return services;
      //return UserModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<ItemAdicionadoModel> addItem(
      ItemModel item, servico, int qtd, double valor) async {
    String url = '${Urls.baseUrl}servico/adicionarProduto.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'servico': servico, 'produto': item.id, 'qtd': qtd, 'valor': valor});

    try {
      var response = await dio.post(url, data: formData);
      return ItemAdicionadoModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<bool> discount(servico, double desconto) async {
    String url = '${Urls.baseUrl}servico/desconto.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'servico': servico, 'desconto': desconto});

    try {
      await dio.post(url, data: formData);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> manPower(servico, double mdo) async {
    String url = '${Urls.baseUrl}servico/maodeobra.php';
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap(
        {'servico': servico, 'mdo': mdo});

    print(servico);
    print(mdo);

    try {
      var res  = await dio.post(url, data: formData);
      print(res.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<ItemAdicionadoModel> getAddedItems(String id) async {
    String url = '${Urls.baseUrl}servico/itensAdicionados.php';
    Dio dio = new Dio();

    try {
      var response = await dio.get(url, queryParameters: {'servico': id});

      return ItemAdicionadoModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }
}
