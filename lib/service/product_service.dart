import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/shared/urls.dart';

class ProductService {
  static Future<List<ProductModel>> searchProducts(
      String loja, String busca) async {
    List<ProductModel> products = new List();
    String url = '${Urls.baseUrl}estoque/busca.php';
    Dio dio = new Dio();
    try {
      var response = await dio.get(url, queryParameters: {
        'loja': loja,
        'busca': busca,
      });

      json.decode(response.data).forEach((element) {
        products.add(ProductModel.fromJson(element));
      });

      return products;
    } catch (e) {
      return null;
    }
  }

  static Future<ProductModel> add(
    ProductModel p,
  ) async {
    String url = '${Urls.baseUrl}estoque/adicionar.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'nome': p.nome.toUpperCase(),
      'aplicacao': p.aplicacao.toUpperCase(),
      'valorPago': p.valorPago,
      'valorVenda': p.valorVenda,
      'qtd': p.qtd,
      'qtdMin': p.qtdMin,
      'loja': p.lojaId,
      'codigo': p.codigo.toUpperCase()
    });
    try {
      var response = await dio.post(url, data: formData);
      //print(response.data);
      return ProductModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<ProductModel> edit(
    ProductModel p,
  ) async {
    String url = '${Urls.baseUrl}estoque/editar.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'id': p.id,
      'nome': p.nome.toUpperCase(),
      'aplicacao': p.aplicacao.toUpperCase(),
      'valorPago': p.valorPago,
      'valorVenda': p.valorVenda,
      'qtd': p.qtd,
      'qtdMin': p.qtdMin,
      'loja': p.lojaId,
      'codigo': p.codigo.toUpperCase()
    });
    try {
      var response = await dio.post(url, data: formData);
      return ProductModel.fromJson(json.decode(response.data));
    } catch (e) {
      return null;
    }
  }

  static Future<bool> delete(id) async {
    String url = '${Urls.baseUrl}estoque/excluir.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'id': id,
    });
    try {
      var response = await dio.post(url, data: formData);      
      return json.decode(response.data);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addToStock(id, qtd) async {
    String url = '${Urls.baseUrl}estoque/entrada.php';
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      'id': id,
      'qtd': qtd,
    });
    try {
      var response = await dio.post(url, data: formData);      
      return json.decode(response.data);
    } catch (e) {
      return false;
    }
  }
}
