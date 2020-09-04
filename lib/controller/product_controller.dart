import 'package:flutter/material.dart';
import 'package:oficina/api_requests/product_requests.dart';
import 'package:oficina/model/create_product_data_model.dart';
import 'package:oficina/model/edit_product_data_model.dart';
import 'package:oficina/model/search_product_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';

class ProductController {
  ProductRequests requests;

  ProductController() {
    requests = ProductRequests();
  }

  Future<CreateProductDataModel> create(data, context, scaffoldKey) async {
    CreateProductDataModel res = await requests.create(data);

    if (res != null) {
      Utils.showInSnackBar('Produto adicionado!', Colors.green, scaffoldKey);
      return res;
    }
    Utils.showInSnackBar('Erro ao adicionar produto', Colors.red, scaffoldKey);
    return null;
  }

  Future<EditProductDataModel> edit(
      data, id, bool delete, context, scaffoldKey) async {
    EditProductDataModel res = await requests.edit(data, id);

    String messageSuccess = delete ? 'Produto exluido!' : 'Produto editado!';
    String messageError =
        delete ? 'Erro ao excluir produto!' : 'Erro ao editar produto!';

    if (res != null) {
      Utils.showInSnackBar(messageSuccess, Colors.green, scaffoldKey);
    }

    Utils.showInSnackBar(messageError, Colors.red, scaffoldKey);
    return null;
  }

  Future<SearchProductDataModel> search(name, scaffoldKey) async {
    SearchProductDataModel res = await requests.search(
        name, SessionVariables.userDataModel.data.data.shop.id);

    if (res != null) return res;
    Utils.showInSnackBar('Erro ao adicionar produto', Colors.red, scaffoldKey);
    return null;
  }
}
