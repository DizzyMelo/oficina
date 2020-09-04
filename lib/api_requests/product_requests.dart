import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oficina/model/create_product_data_model.dart';
import 'package:oficina/model/edit_product_data_model.dart';
import 'package:oficina/model/search_product_data_model.dart';

class ProductRequests {
  Future<CreateProductDataModel> create(data) async {
    String url = '${DotEnv().env['BASE_URL']}/products/';

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));

      if (res.statusCode == 201) {
        return CreateProductDataModel.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<EditProductDataModel> edit(data, id) async {
    String url = '${DotEnv().env['BASE_URL']}/products/$id';

    try {
      var res = await http.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(data));
      if (res.statusCode == 200) {
        return EditProductDataModel.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<SearchProductDataModel> search(name, shop) async {
    String url = '${DotEnv().env['BASE_URL']}/products/search/$name/$shop';

    try {
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (res.statusCode == 200) {
        return SearchProductDataModel.fromJson(json.decode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
