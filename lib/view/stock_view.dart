import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/search_textfield_component.dart';
import 'package:oficina/controller/product_controller.dart';
import 'package:oficina/model/search_product_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class StockView extends StatefulWidget {
  @override
  _StockViewState createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrAmount = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrCode = TextEditingController();
  TextEditingController ctrDescription = TextEditingController();
  TextEditingController ctrQtd = TextEditingController();
  TextEditingController ctrQtdMin = TextEditingController(text: '1');
  TextEditingController ctrPricePaid = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');
  TextEditingController ctrPriceSale = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SearchProductDataModel _searchProductDataModel;

  ProductController _productController;
  bool loadingCreate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.square,
              title: 'Estoque',
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            MainTextFieldComponent(
                                controller: ctrName,
                                icon: LineIcons.user,
                                hint: 'Nomo do produto'),
                            MainTextFieldComponent(
                                controller: ctrCode,
                                icon: LineIcons.code,
                                hint: 'Código'),
                            MainTextFieldComponent(
                                controller: ctrDescription,
                                icon: LineIcons.wrench,
                                hint: 'Descrição'),
                            MainTextFieldComponent(
                                controller: ctrPricePaid,
                                icon: LineIcons.money,
                                hint: 'Valor de Compra'),
                            MainTextFieldComponent(
                                controller: ctrPriceSale,
                                icon: LineIcons.money,
                                hint: 'Valor de Venda'),
                            MainTextFieldComponent(
                                controller: ctrQtd,
                                icon: LineIcons.calculator,
                                hint: 'Quantidade'),
                            MainTextFieldComponent(
                                controller: ctrQtdMin,
                                icon: LineIcons.calculator,
                                hint: 'Quantidade Mínima'),
                            SizedBox(
                              height: 20,
                            ),
                            loadingCreate
                                ? Center(
                                    child: LoadingComponent(),
                                  )
                                : MainButtomComponent(
                                    title: 'ADICIONAR', function: createProduct)
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SearchTextFieldComponent(
                                controller: ctrSearch,
                                hint: 'Buscar produto...',
                                function: search),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: _searchProductDataModel == null ||
                                        _searchProductDataModel
                                                .data.data.length ==
                                            0
                                    ? Center(
                                        child: Text(
                                            'Nenhum produto a ser exibido'),
                                      )
                                    : Scrollbar(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                            thickness: 0.6,
                                            color: Colors.grey[800],
                                          ),
                                          itemCount: _searchProductDataModel
                                              .data.data.length,
                                          itemBuilder: (context, index) {
                                            Datum product =
                                                _searchProductDataModel
                                                    .data.data[index];

                                            return ListTile(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/edit_product',
                                                      arguments: product);
                                                },
                                                title: Text(
                                                  product.name ?? '',
                                                  style: Style.clientNameText,
                                                ),
                                                subtitle: Text(
                                                    product.description ?? ''));
                                          },
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
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

  search(name) async {
    SearchProductDataModel res =
        await _productController.search(name, _scaffoldKey);

    setState(() {
      _searchProductDataModel = res;
    });
  }

  createProduct() async {
    Map<String, dynamic> data = {
      "name": ctrName.text,
      "description": ctrDescription.text,
      "code": ctrCode.text,
      "current_amount": ctrQtd.text,
      "minimum_amount": ctrQtdMin.text,
      "price_sale": Utils.clearPrice(ctrPriceSale.text),
      "price_bought": Utils.clearPrice(ctrPricePaid.text),
      "shop": SessionVariables.userDataModel.data.data.shop.id
    };

    print(data);

    this.changeLoadingCreateState();
    await _productController.create(data, context, _scaffoldKey);
    this.changeLoadingCreateState();
  }

  changeLoadingCreateState() {
    setState(() {
      loadingCreate = !loadingCreate;
    });
  }

  @override
  void initState() {
    super.initState();
    _productController = ProductController();
  }
}
