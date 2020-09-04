import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/controller/product_controller.dart';
import 'package:oficina/model/search_product_data_model.dart';
import 'package:oficina/shared/utils.dart';

class EditProductView extends StatefulWidget {
  final Datum product;

  EditProductView({@required this.product});
  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
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

  bool loading = false;
  bool loadingDelete = false;

  ProductController _productController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          AppBarComponent(
            icon: LineIcons.plus,
            title: 'Editar Produto',
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 500,
              width: 450,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    Expanded(child: Container()),
                    loading
                        ? Center(
                            child: LoadingComponent(),
                          )
                        : MainButtomComponent(title: 'SALVAR', function: edit),
                    SizedBox(
                      height: 10,
                    ),
                    loadingDelete
                        ? Center(
                            child: LoadingComponent(
                              delete: true,
                            ),
                          )
                        : CancelButtomComponent(
                            title: 'EXCLUIR', function: delete)
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  edit() async {
    Map<String, dynamic> data = {
      "name": ctrName.text,
      "description": ctrDescription.text,
      "code": ctrCode.text,
      "current_amount": ctrQtd.text,
      "minimum_amount": ctrQtdMin.text,
      "price_sale": Utils.clearPrice(ctrPriceSale.text),
      "price_bought": Utils.clearPrice(ctrPricePaid.text),
    };
    this.changeLoadingState();
    await _productController.edit(
        data, widget.product.id, false, context, _scaffoldKey);
    this.changeLoadingState();
  }

  delete() async {
    Map<String, dynamic> data = {
      "active": false,
    };
    this.changeLoadingDeleteState();
    await _productController.edit(
        data, widget.product.id, true, context, _scaffoldKey);
    this.changeLoadingDeleteState();
  }

  changeLoadingState() {
    setState(() {
      loading = !loading;
    });
  }

  changeLoadingDeleteState() {
    setState(() {
      loadingDelete = !loadingDelete;
    });
  }

  @override
  void initState() {
    super.initState();
    ctrName.text = widget.product.name;
    ctrCode.text = widget.product.code;
    ctrDescription.text = widget.product.description;
    ctrQtd.text = widget.product.currentAmount.toString();
    ctrQtdMin.text = widget.product.minimumAmount.toString();
    ctrPricePaid.text =
        widget.product.priceBought.toDouble().toStringAsFixed(2);
    ctrPriceSale.text = widget.product.priceSale.toDouble().toStringAsFixed(2);

    _productController = ProductController();
  }
}
