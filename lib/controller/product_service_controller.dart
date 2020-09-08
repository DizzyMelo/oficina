import 'package:flutter/material.dart';
import 'package:oficina/api_requests/product_service_requests.dart';
import 'package:oficina/model/create_product_service_data_model.dart';
import 'package:oficina/shared/utils.dart';

class ProductServiceController {
  ProductServiceRequests requests;

  ProductServiceController() {
    requests = ProductServiceRequests();
  }

  Future<CreateProductServiceDataModel> create(data, scaffoldKey) async {
    CreateProductServiceDataModel res = await requests.create(data);
    if (res != null) {
      Utils.showInSnackBar('Produto adicionado!', Colors.green, scaffoldKey);
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar o produto!', Colors.red, scaffoldKey);
      return null;
    }
  }

  Future<bool> delete(id, scaffoldKey) async {
    bool res = await requests.delete(id);
    if (res) {
      Utils.showInSnackBar('Produto removido!', Colors.green, scaffoldKey);
      return res;
    } else {
      Utils.showInSnackBar(
          'Erro ao remover o produto!', Colors.red, scaffoldKey);
      return false;
    }
  }
}
