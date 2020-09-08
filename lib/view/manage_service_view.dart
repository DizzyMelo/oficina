import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/search_textfield_component.dart';
import 'package:oficina/controller/product_controller.dart';
import 'package:oficina/model/search_product_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ManageServiceView extends StatefulWidget {
  final String serviceId;

  ManageServiceView({this.serviceId = '5f564c72f08acb0004cbbfc7'});
  @override
  _ManageServiceViewState createState() => _ManageServiceViewState();
}

class _ManageServiceViewState extends State<ManageServiceView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrSearch = TextEditingController();

  SearchProductDataModel _searchProductDataModel;
  ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double mainContainerWidth = screen.width - 20;
    double mainContainerHeight = 500;
    double secondaryContainerWidth = mainContainerWidth / 3;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.automobile,
              title: 'Serviço',
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: mainContainerHeight,
                width: mainContainerWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: mainContainerHeight,
                      width: secondaryContainerWidth,
                      child: Column(
                        children: [
                          SearchTextFieldComponent(
                              controller: ctrSearch,
                              hint: 'Buscar produtos',
                              function: searchProducts),
                          Expanded(
                            child: _searchProductDataModel == null ||
                                    _searchProductDataModel.data.data.length ==
                                        0
                                ? Center(
                                    child: Text('Nenhum produto a ser exibido'),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                        itemCount: _searchProductDataModel
                                            .data.data.length,
                                        itemBuilder: (context, index) {
                                          Datum product =
                                              _searchProductDataModel
                                                  .data.data[index];
                                          return ListTile(
                                            title: Text(
                                              product.name,
                                              style: Style.itemNameText,
                                            ),
                                            trailing: Text(
                                                Utils.formatMoney(product
                                                        .priceSale
                                                        .toDouble()) ??
                                                    'no-data',
                                                style: Style.itemValueText),
                                            subtitle: Text(
                                                '${product.currentAmount} itens disponiveis' ??
                                                    'no-data',
                                                style: Style.itemValueText),
                                          );
                                        }),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: mainContainerHeight,
                        width: secondaryContainerWidth,
                        decoration: BoxDecoration(
                          border: Border(
                            left:
                                BorderSide(width: 0.5, color: Colors.grey[800]),
                            right:
                                BorderSide(width: 0.5, color: Colors.grey[800]),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text('Itens Adicionados'),
                            Expanded(
                              child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          'nome do produto',
                                          style: Style.itemNameText,
                                        ),
                                        trailing: Text(
                                            Utils.formatMoney(50.0) ??
                                                'no-data',
                                            style: Style.itemValueText),
                                        subtitle: Text(
                                            '10 itens disponiveis' ?? 'no-data',
                                            style: Style.itemValueText),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: mainContainerHeight,
                      width: secondaryContainerWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Marcelo Ribas'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Palio Fire 2008'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Antonio Eufrasio'),
                          Expanded(child: Container()),
                          MainButtomComponent(
                              title: 'CONCLUIR', function: () {}),
                          SizedBox(
                            height: 10,
                          ),
                          CancelButtomComponent(
                              title: 'CANCELAR', function: () {})
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchProducts(name) async {
    SearchProductDataModel res =
        await _productController.search(name, _scaffoldKey);
    if (res != null) {
      setState(() {
        _searchProductDataModel = res;
      });
    } else {
      print('pesquisa retornou null');
    }
  }
}
