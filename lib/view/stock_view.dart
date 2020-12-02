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
                              hint: 'Valor de Compra',
                              label: true,
                            ),
                            MainTextFieldComponent(
                              controller: ctrPriceSale,
                              icon: LineIcons.money,
                              hint: 'Valor de Venda',
                              label: true,
                            ),
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
                                              Container(
                                            height: 0.5,
                                            width: double.infinity,
                                            color: Style.secondaryColor,
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
                                              trailing: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Venda: ',
                                                          style: Style
                                                              .valueTitleText),
                                                      TextSpan(
                                                          text: Utils.formatMoney(
                                                              product
                                                                  .priceSale),
                                                          style: Style
                                                              .totalValueText),
                                                    ]),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Compra: ',
                                                          style: Style
                                                              .valueTitleText),
                                                      TextSpan(
                                                          text: Utils.formatMoney(
                                                              product
                                                                  .priceBought),
                                                          style: Style
                                                              .totalValueText),
                                                    ]),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Lucro: ',
                                                          style: Style
                                                              .valueTitleText),
                                                      TextSpan(
                                                          text:
                                                              '${Utils.calculateProfit(product.priceSale, product.priceBought)}',
                                                          style: Style
                                                              .totalValueText),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Text(
                                                'Qtd.${product.currentAmount} - Min. Qtd. ${product.minimumAmount}',
                                                style: Style.smallGreyText,
                                              ),
                                            );
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
    SearchProductDataModel res = await _productController.search(name, context);

    setState(() {
      _searchProductDataModel = res;
    });
  }

  createProduct() async {
    Map<String, dynamic> data = Utils.validateProductData({
      "name": ctrName.text,
      "description": ctrDescription.text,
      "code": ctrCode.text,
      "current_amount": ctrQtd.text,
      "minimum_amount": ctrQtdMin.text,
      "price_sale": Utils.clearPrice(ctrPriceSale.text),
      "price_bought": Utils.clearPrice(ctrPricePaid.text),
      "shop": SessionVariables.userDataModel.data.data.shop.id
    });

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
