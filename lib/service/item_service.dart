import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oficina/model/item_model.dart';
import 'package:oficina/shared/urls.dart';

class ItemService {
  static Future<List<ItemModel>> searchItems(String store, String txt) async {
    List<ItemModel> items = new List();
    String url = '${Urls.baseUrl}estoque/busca.php';
    Dio dio = new Dio();
    
    try{
      var response = await dio.get(url, 
      queryParameters: {
        'loja': store,
        'busca': txt
      });

      json.decode(response.data).forEach((element) {
        items.add(ItemModel.fromJson(element));
      });
      
      return items;
    }catch(e){
      return null;
    }
  }
}
