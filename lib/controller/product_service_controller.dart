import 'package:flutter/material.dart';
import 'package:oficina/api_requests/product_service_requests.dart';
import 'package:oficina/model/create_product_service_data_model.dart';
import 'package:oficina/shared/utils.dart';

class ProductServiceController {
  ProductServiceRequests requests;

  ProductServiceController() {
    requests = ProductServiceRequests();
  }

  Future<CreateProductServiceDataModel> create(
      data, BuildContext context) async {
    CreateProductServiceDataModel res = await requests.create(data);
    if (res != null) {
      Utils.showMessage('Produto adicionado!', context, color: Colors.green);
      return res;
    } else {
      Utils.showMessage('Erro ao adicionar o produto!', context);
      return null;
    }
  }

  Future<bool> delete(id, BuildContext context) async {
    bool res = await requests.delete(id);
    if (res) {
      Utils.showMessage('Produto removido!', context, color: Colors.green);
      return res;
    } else {
      Utils.showMessage('Erro ao remover o produto!', context);
      return false;
    }
  }
}
