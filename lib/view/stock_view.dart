import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/service/product_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class StockView extends StatefulWidget {
  @override
  _StockViewState createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrCode = TextEditingController();
  TextEditingController ctrApplication = TextEditingController();
  TextEditingController ctrPricePaid = TextEditingController();
  TextEditingController ctrPriceSale = TextEditingController();
  TextEditingController ctrQtd = TextEditingController();
  TextEditingController ctrQtdMin = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ProductModel> products = new List();

  ProductModel selectedProduct;

  Widget createTextField(
      String hint, TextEditingController controller, IconData icon) {
    return Column(
      children: [
        TextField(
          style: Style.textField,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Colors.grey[400],
              ),
              hintText: hint,
              hintStyle: Style.textField,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Colors.grey[800],
              ))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(LineIcons.close),
                  onPressed: () => Navigator.pop(context)),
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
                              createTextField('Nome', ctrName, LineIcons.user),
                              createTextField(
                                  'Código', ctrCode, LineIcons.code),
                              createTextField('Aplicação', ctrApplication,
                                  LineIcons.wrench),
                              createTextField('Valor de Compra', ctrPricePaid,
                                  LineIcons.money),
                              createTextField('Valor de Venda', ctrPriceSale,
                                  LineIcons.money),
                              createTextField(
                                  'Quantidade', ctrQtd, LineIcons.calculator),
                              createTextField('Quantidade Mínima', ctrQtdMin,
                                  LineIcons.calculator),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ))),
                  Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextField(
                              onSubmitted: searchProducts,
                              style: Style.textField,
                              controller: ctrSearch,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    LineIcons.search,
                                    size: 20,
                                    color: Colors.grey[400],
                                  ),
                                  hintText: 'Buscar produto...',
                                  hintStyle: Style.textField,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[800],
                                  ))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                                    child: Scrollbar(
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  thickness: 0.6,
                                  color: Colors.grey[800],
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  ProductModel productModel = products[index];

                                  return ListTile(
                                      onTap: () {
                                        fillForm(productModel);
                                      },
                                      title: Text(
                                        productModel.nome ?? '',
                                        style: Style.clientNameText,
                                      ),
                                      subtitle:
                                          Utils.validadeAmount(productModel),
                                      trailing: Container(
                                        width: 170,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Valor de Compra:',
                                                  style: Style.labelValueText,
                                                ),
                                                Text(
                                                  '${Utils.formatMoney(double.parse(productModel.valorPago))}',
                                                  style: Style.valuePaidText,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Valor de Venda:',
                                                  style: Style.labelValueText,
                                                ),
                                                Text(
                                                  '${Utils.formatMoney(double.parse(productModel.valorVenda))}',
                                                  style: Style.valueSaleText,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Lucro Bruto:',
                                                  style: Style.labelValueText,
                                                ),
                                                Text(
                                                  '${Utils.formatMoney(double.parse(productModel.valorVenda) - double.parse(productModel.valorPago))}',
                                                  style: Style.valueProfitText,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            )))
                          ],
                        ),
                      )),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  searchProducts(String txt) async {
    List<ProductModel> tempProducts =
        await ProductService.searchProducts('1', txt);

    if (tempProducts != null) {
      setState(() {
        products = tempProducts;
      });
    }
  }

  fillForm(ProductModel product) {
    ctrName.text = product.nome;
    ctrCode.text = product.codigo;
    ctrApplication.text = product.aplicacao;
    ctrPricePaid.text = product.valorPago;
    ctrPriceSale.text = product.valorVenda;
    ctrQtd.text = product.qtd;
    ctrQtdMin.text = product.qtdMin;
  }
}
