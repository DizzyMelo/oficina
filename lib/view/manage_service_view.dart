import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/action_textfield_component.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/search_textfield_component.dart';
import 'package:oficina/components/select_role_component.dart';
import 'package:oficina/components/service_info_component.dart';
import 'package:oficina/controller/product_controller.dart';
import 'package:oficina/controller/product_service_controller.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/model/create_product_service_data_model.dart';
import 'package:oficina/model/detail_service_data_model.dart';
import 'package:oficina/model/search_product_data_model.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ManageServiceView extends StatefulWidget {
  final String serviceId;

  ManageServiceView({this.serviceId});
  @override
  _ManageServiceViewState createState() => _ManageServiceViewState();
}

class _ManageServiceViewState extends State<ManageServiceView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrAmount = TextEditingController();
  TextEditingController ctrWarranty = TextEditingController();

  TextEditingController ctrHow = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  TextEditingController ctrDiscount = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  SearchProductDataModel _searchProductDataModel;
  DetailServiceDataModel _detailServiceDataModel;
  ProductController _productController = ProductController();
  ServiceController _serviceController = ServiceController();
  ProductServiceController _productServiceController =
      ProductServiceController();

  String productId;
  String addedProductId;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double mainContainerWidth = screen.width - 20;
    double mainContainerHeight = 600;
    double secondaryContainerWidth = mainContainerWidth / 3;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: _detailServiceDataModel == null
            ? Center(
                child: LoadingComponent(),
              )
            : Column(
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
                                          _searchProductDataModel
                                                  .data.data.length ==
                                              0
                                      ? Center(
                                          child: Text(
                                              'Nenhum produto a ser exibido'),
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
                                                  onTap: () {
                                                    productId = product.id;
                                                    requestAmount();
                                                  },
                                                  title: Text(
                                                    product.name,
                                                    style: Style.itemNameText,
                                                  ),
                                                  trailing: Text(
                                                      Utils.formatMoney(product
                                                              .priceSale
                                                              .toDouble()) ??
                                                          'no-data',
                                                      style:
                                                          Style.itemValueText),
                                                  subtitle: Text(
                                                      '${product.currentAmount} itens disponiveis' ??
                                                          'no-data',
                                                      style:
                                                          Style.itemValueText),
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
                                  left: BorderSide(
                                      width: 0.5, color: Colors.grey[800]),
                                  right: BorderSide(
                                      width: 0.5, color: Colors.grey[800]),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text('Itens Adicionados'),
                                  Expanded(
                                    child: _detailServiceDataModel.data.data
                                                .addedProducts.length ==
                                            0
                                        ? Center(
                                            child: Text(
                                                'Nenhum produto a ser exibido'),
                                          )
                                        : Scrollbar(
                                            child: ListView.builder(
                                                itemCount:
                                                    _detailServiceDataModel
                                                        .data
                                                        .data
                                                        .addedProducts
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  AddedProduct product =
                                                      _detailServiceDataModel
                                                          .data
                                                          .data
                                                          .addedProducts[index];
                                                  return ListTile(
                                                    onLongPress: () {
                                                      addedProductId =
                                                          product.id;
                                                      Utils.confirmDialog(
                                                          'Remover Produto',
                                                          'Tem certeza que deseja remover este produto',
                                                          removeProduct,
                                                          'REMOVER',
                                                          context);
                                                    },
                                                    title: Text(
                                                      product.product.name,
                                                      style: Style.itemNameText,
                                                    ),
                                                    trailing: Text(
                                                        Utils.formatMoney(product
                                                                .totalPrice
                                                                .toDouble()) ??
                                                            'no-data',
                                                        style: Style
                                                            .itemValueText),
                                                    subtitle: Text(
                                                        '${product.amount} itens' ??
                                                            'no-data',
                                                        style: Style
                                                            .itemValueText),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Informações Gerais'),
                                Column(
                                  children: [
                                    ServiceInfoComponent(
                                        title: 'Cliente',
                                        info: _detailServiceDataModel
                                            .data.data.client.name),
                                    ServiceInfoComponent(
                                        title: 'Carro',
                                        info: _detailServiceDataModel
                                            .data.data.car.name),
                                    ServiceInfoComponent(
                                        title: 'Colaborador',
                                        info: _detailServiceDataModel
                                            .data.data.client.name),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ActionTextFieldComponent(
                                  controller: ctrHow,
                                  icon: LineIcons.hand_stop_o,
                                  hint: 'Mão de obra',
                                  function: editServiceHow,
                                ),
                                ActionTextFieldComponent(
                                  controller: ctrDiscount,
                                  icon: LineIcons.money,
                                  hint: 'Desconto',
                                  function: editServiceDiscount,
                                ),
                                ActionTextFieldComponent(
                                  controller: ctrWarranty,
                                  icon: LineIcons.money,
                                  hint:
                                      'Garantia em ${_detailServiceDataModel.data.data.warrantyUnity}',
                                  function: editServiceDiscount,
                                ),
                                Expanded(child: Container()),
                                Column(
                                  children: [
                                    ServiceInfoComponent(
                                        title: 'Garantia',
                                        info:
                                            '${_detailServiceDataModel.data.data.warranty.toString()} ${_detailServiceDataModel.data.data.warrantyUnity}'),
                                    ServiceInfoComponent(
                                        title: 'Mão de Obra',
                                        info: Utils.formatMoney(
                                            _detailServiceDataModel
                                                .data.data.how)),
                                    ServiceInfoComponent(
                                        title: 'Desconto',
                                        info: Utils.formatMoney(
                                            _detailServiceDataModel
                                                .data.data.discount)),
                                    ServiceInfoComponent(
                                        title: 'Total',
                                        info: Utils.formatMoney(
                                            _detailServiceDataModel
                                                .data.data.value)),
                                  ],
                                ),
                                MainButtomComponent(
                                    title: 'CONCLUIR',
                                    function: () {
                                      Navigator.pushNamed(context, '/payment',
                                          arguments: _detailServiceDataModel);
                                    }),
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

  requestAmount() {
    Utils.requestAmount('Quantidade', 'Quantidade', addProduct, 'ADICIONAR',
        ctrAmount, context);
  }

  addProduct() async {
    Map<String, dynamic> data = {
      "service": widget.serviceId,
      "product": productId,
      "amount": int.parse(ctrAmount.text)
    };

    Navigator.pop(context);
    CreateProductServiceDataModel res =
        await _productServiceController.create(data, _scaffoldKey);

    if (res != null) this.getServiceDetails();
    productId = '';
  }

  removeProduct() async {
    bool res =
        await _productServiceController.delete(addedProductId, _scaffoldKey);
    Navigator.pop(context);
    addedProductId = '';
    if (res) this.getServiceDetails();
  }

  editServiceHow() async {
    Map<String, dynamic> data = {'how': Utils.clearPrice(ctrHow.text)};
    bool res = await _serviceController.edit(
        data, widget.serviceId, 'update-how', _scaffoldKey);

    if (res) this.getServiceDetails();
  }

  editServiceDiscount() async {
    Map<String, dynamic> data = {
      'discount': Utils.clearPrice(ctrDiscount.text)
    };
    bool res = await _serviceController.edit(
        data, widget.serviceId, 'update-discount', _scaffoldKey);

    if (res) this.getServiceDetails();
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

  getServiceDetails() async {
    DetailServiceDataModel res = await _serviceController.getServiceDetails(
        widget.serviceId, _scaffoldKey);

    if (res != null) {
      setState(() {
        _detailServiceDataModel = res;
      });
      ctrHow.text = _detailServiceDataModel.data.data.how.toStringAsFixed(2);
      ctrDiscount.text =
          _detailServiceDataModel.data.data.discount.toStringAsFixed(2);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getServiceDetails();
  }
}
