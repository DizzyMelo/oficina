import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/service/product_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class WorkerView extends StatefulWidget {
  @override
  _WorkerViewState createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrCode = TextEditingController();
  TextEditingController ctrApplication = TextEditingController();
  TextEditingController ctrQtd = TextEditingController();
  TextEditingController ctrQtdMin = TextEditingController();
  TextEditingController ctrPricePaid = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');
  TextEditingController ctrPriceSale = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RaisedButton(
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LineIcons.close,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Excluir",
                                            style: Style.serviceButton,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {}),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  selectedProduct == null ? Container() :
                                  RaisedButton(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LineIcons.pencil,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Editar",
                                            style: Style.serviceButton,
                                          ),
                                        ],
                                      ),
                                      onPressed: editProduct),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                      color: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LineIcons.plus,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Adicionar",
                                            style: Style.serviceButton,
                                          ),
                                        ],
                                      ),
                                      onPressed: addProduct),
                                ],
                              )
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
                                        setState(() {
                                          selectedProduct = productModel;
                                        });
                                        
                                      },
                                      title: Text(
                                        productModel.nome ?? '',
                                        style: Style.clientNameText,
                                      ),
                                      subtitle:
                                          Utils.validadeAmount(productModel),
                                      trailing: Container(
                                        width: 190,
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

  addProduct() async {
    String valorPago = ctrPricePaid.text.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", ".");
    String valorVenda = ctrPriceSale.text.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", ".");
    ProductModel p = new ProductModel(
      nome: ctrName.text,
      aplicacao: ctrApplication.text,
      valorPago: valorPago,
      valorVenda: valorVenda,
      qtd: ctrQtd.text,
      qtdMin: ctrQtdMin.text,
      sts: "1",
      lojaId: '1',
      codigo: ctrCode.text
    );
    ProductModel product = await ProductService.add(p);

    if(product != null){
      Utils.showInSnackBar('Produto adicionado', Colors.green, _scaffoldKey);
    }else{
      Utils.showInSnackBar('Alogo deu erro ao adicionar o produto', Colors.red, _scaffoldKey);
    }
  }

  editProduct() async {
    String valorPago = ctrPricePaid.text.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", ".");
    String valorVenda = ctrPriceSale.text.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", ".");
    ProductModel p = new ProductModel(
      id: selectedProduct.id,
      nome: ctrName.text,
      aplicacao: ctrApplication.text,
      valorPago: valorPago,
      valorVenda: valorVenda,
      qtd: ctrQtd.text,
      qtdMin: ctrQtdMin.text,
      sts: "1",
      lojaId: '1',
      codigo: ctrCode.text
    );
    ProductModel product = await ProductService.edit(p);
    if(product != null){
      Utils.showInSnackBar('Produto editado', Colors.green, _scaffoldKey);
    }else{
      Utils.showInSnackBar('Alogo deu erro ao editar o produto', Colors.red, _scaffoldKey);
    }
  }
}
