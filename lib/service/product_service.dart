import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/shared/urls.dart';

class ProductService {
  static Future<List<ProductModel>> searchProducts(String loja, String busca) async {
    List<ProductModel> products = new List();
    String url = '${Urls.baseUrl}estoque/busca.php';
    Dio dio = new Dio();
    try{
      var response = await dio.get(url, 
      queryParameters: {
        'loja': loja,
        'busca': busca,
      });

      json.decode(response.data).forEach((element) {
        products.add(ProductModel.fromJson(element));
      });
      
      return products;
    }catch(e){
      return null;
    }
  }
}