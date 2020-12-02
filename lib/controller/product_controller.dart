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
      Utils.showMessage('Produto adicionado!', context, color: Colors.green);
      return res;
    }
    Utils.showMessage(
      'Erro ao adicionar produto',
      context,
    );
    return null;
  }

  Future<EditProductDataModel> edit(
      data, id, bool delete, context, scaffoldKey) async {
    EditProductDataModel res = await requests.edit(data, id);

    String messageSuccess = delete ? 'Produto exluido!' : 'Produto editado!';
    String messageError =
        delete ? 'Erro ao excluir produto!' : 'Erro ao editar produto!';

    if (res != null) {
      Utils.showMessage(messageSuccess, context, color: Colors.green);
    }

    Utils.showMessage(messageError, context);
    return null;
  }

  Future<SearchProductDataModel> search(name, BuildContext context) async {
    SearchProductDataModel res = await requests.search(
        name, SessionVariables.userDataModel.data.data.shop.id);

    if (res != null ||
        res.data == null ||
        res.data.data == null ||
        res.data.data.length == 0) return res;
    Utils.showMessage('A pesquisa não encontrou nenhum resultado', context);
    return null;
  }
}
