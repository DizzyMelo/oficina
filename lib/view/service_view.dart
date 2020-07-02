import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/model/added_item_model.dart';
import 'package:oficina/model/item_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/service/item_service.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/shared/print.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';
import 'package:oficina/widget/service_info_widget.dart';

class ServiceView extends StatefulWidget {
  final ServiceModel serviceModel;

  ServiceView({this.serviceModel});
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrEdit = TextEditingController();
  TextEditingController ctrDiscount = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  TextEditingController ctrManPower = MoneyMaskedTextController(
      leftSymbol: "R\$ ", decimalSeparator: ',', thousandSeparator: '.');

  TextEditingController ctrAmount = TextEditingController();

  ItemAdicionadoModel addedItems;
  Valores valores;
  List<ItemModel> items = new List();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                AppBarComponent(icon: LineIcons.automobile, title: 'Serviço',),
                Center(
                  child: Container(
                      height: 665,
                      width: 1000,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            blurRadius:
                                2.0, // has the effect of softening the shadow
                            spreadRadius:
                                2.0, // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          TextField(
                                            style: Style.textField,
                                            onSubmitted: searchItems,
                                            controller: ctrSearch,
                                            decoration: InputDecoration(
                                                //contentPadding: EdgeInsets.all(0),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: Colors.grey[400],
                                                ),
                                                hintText: "Buscar Produto ...",
                                                hintStyle: Style.textField,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey[800],
                                                ))),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: items.length > 0
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    itemExtent: 45,
                                                    itemCount: items.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      ItemModel item =
                                                          items[index];
                                                      return ListTile(
                                                        onTap: () {
                                                          _itemsAmount(item);
                                                        },
                                                        title: Text(
                                                            item.nome ??
                                                                'no-data',
                                                            style: Style
                                                                .itemNameText),
                                                        trailing: Text(
                                                            Utils.formatMoney(double
                                                                    .parse(item
                                                                        .valorVenda)) ??
                                                                'no-data',
                                                            style: Style
                                                                .itemValueText),
                                                        subtitle: Text(
                                                            'Qtd.: ${item.qtd} - Qtd. Min.: ${item.qtdMin}' ??
                                                                'no-data',
                                                            style: Style
                                                                .itemValueText),
                                                      );
                                                    })
                                                : Center(
                                                    child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.search,
                                                        color: Colors.grey[400],
                                                        size: 80,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          'Busque itens na barra acima!', style: Style.serviceMessage,),
                                                    ],
                                                  )),
                                          )
                                        ],
                                      ),
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'ITENS ADICIONADOS',
                                              style: Style.mediumText,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 23,
                                          ),
                                          Divider(
                                            color: Colors.grey[500],
                                            thickness: 2,
                                          ),
                                          Expanded(
                                            child: addedItems != null &&
                                                    addedItems
                                                            .produtosAdicionados
                                                            .length >
                                                        0
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    itemExtent: 45,
                                                    itemCount: addedItems ==
                                                            null
                                                        ? 0
                                                        : addedItems
                                                            .produtosAdicionados
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      ProdutosAdicionado p =
                                                          addedItems
                                                                  .produtosAdicionados[
                                                              index];
                                                      return ListTile(
                                                        onTap: (){
                                                          ctrEdit.text = p.qtd;
                                                          _editAddedProduct(p);
                                                        },
                                                        title: Text(
                                                          p.nome,
                                                          style: Style
                                                              .itemNameText,
                                                        ),
                                                        subtitle: Text(
                                                          "(${p.qtd} x ${Utils.formatMoney(double.parse(p.valorVenda))})",
                                                          style: Style
                                                              .itemValueText,
                                                        ),
                                                        trailing: Text(
                                                          "${Utils.formatMoney(double.parse(p.valorTotal))}",
                                                          style: Style
                                                              .itemValueText,
                                                        ),
                                                      );
                                                    })
                                                : Center(
                                                    child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        LineIcons.cart_arrow_down,
                                                        color: Colors.grey[400],
                                                        size: 80,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          'Nenhum item adicionado', style: Style.serviceMessage,),
                                                    ],
                                                  )),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey[300]))),
                                          child: Column(
                                            children: [
                                              ServiceInfoWidget(
                                                  'CLIENTE',
                                                  widget
                                                      .serviceModel.nomeCliente
                                                      .toUpperCase(),
                                                  () {},
                                                  LineIcons.user),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ServiceInfoWidget(
                                                  'CARRO',
                                                  widget.serviceModel.modelo
                                                      .toUpperCase(),
                                                  () {},
                                                  LineIcons.car),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ServiceInfoWidget(
                                                  'COLABORADOR',
                                                  widget.serviceModel
                                                      .nomeColaborador
                                                      .toUpperCase(),
                                                  () {},
                                                  LineIcons.wrench),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 100,
                                          child: Column(
                                            children: [
                                              ServiceInfoWidget(
                                                  'DESCONTO',
                                                  valores == null
                                                      ? 'no-data'
                                                      : Utils.formatMoney(
                                                          double.parse(valores
                                                              .desconto)),
                                                  _discount,
                                                  LineIcons.money),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ServiceInfoWidget(
                                                  'MÃO DE OBRA',
                                                  valores == null
                                                      ? 'no-data'
                                                      : Utils.formatMoney(
                                                          double.parse(
                                                              valores.mdo)),
                                                  _manpower,
                                                  LineIcons.hand_grab_o),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ServiceInfoWidget(
                                                  'VALOR TOTAL',
                                                  valores == null
                                                      ? 'no-data'
                                                      : Utils.formatMoney(
                                                          double.parse(valores
                                                              .valorTotal)),
                                                  () {},
                                                  LineIcons.money),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  color: Colors.red,
                  child: Row(
                    children: [
                      Icon(
                        LineIcons.close,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10,),
                      Text('Cancelar', style: Style.serviceButton)
                    ],
                  ),
                  onPressed: () {}),
              SizedBox(width: 10),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  color: Colors.green,
                  child: Row(
                    children: [
                      Icon(
                        LineIcons.print,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10,),
                      Text('Imprimir', style: Style.serviceButton)
                    ],
                  ),
                  onPressed: () {
                    Printer.print(widget.serviceModel, addedItems.produtosAdicionados);
                  }),
              SizedBox(width: 10),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  color: Colors.green,
                  child: Row(
                    children: [
                      Icon(
                        LineIcons.check,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10,),
                      Text('Concluir', style: Style.serviceButton)
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/finish_service',
                        arguments: widget.serviceModel);
                  }),
            ],
          ),
        ));
  }

  getAddedItems() async {
    ItemAdicionadoModel tempItems =
        await ServiceService.getAddedItems(widget.serviceModel.idServico);

    if (tempItems != null) {
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });
    }
  }

  addItem(ItemModel item, int qtd) async {
    double valorTotal = double.parse(item.valorVenda) * qtd;
    ItemAdicionadoModel tempItems = await ServiceService.addItem(
        int.parse(item.id), widget.serviceModel.idServico, qtd, valorTotal);

    if (tempItems != null) {
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });

      Navigator.pop(context);
    }
  }

  bool validateQtd(){
    try{
      int qtd = int.parse(ctrEdit.text);
      if(qtd <= 0){
        return false;
      }
    }catch(e){
      return false;
    }
    return true;
  }

  editItem(ProdutosAdicionado p) async {
    if(!validateQtd()) return;
    int qtd = int.parse(ctrEdit.text);
    double valorTotal = double.parse(p.valorVenda) * qtd;
    ItemAdicionadoModel tempItems = await ServiceService.editItem(widget.serviceModel.idServico, qtd, valorTotal, p);

    if (tempItems != null) {
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });

      Navigator.pop(context);
    }
  }

  removeItem(ProdutosAdicionado item) async {
    ItemAdicionadoModel tempItems = await ServiceService.removeItem(item, widget.serviceModel.idServico);

    if (tempItems != null) {
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });

      Navigator.pop(context);
    }
  }

  searchItems(String txt) async {
    if (txt.length < 3) {
      Utils.showInSnackBar(
          'Digite pelo menos três letras', Colors.red, _scaffoldKey);
      return;
    }
    List<ItemModel> tempItems = await ItemService.searchItems('1', txt);

    if (tempItems != null) {
      setState(() {
        items = tempItems;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getAddedItems();
  }

  void _itemsAmount(item) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Quantidade de Itens", style: Style.dialogTitle,),
          content: TextField(
            controller: ctrAmount,
            style: Style.textField,
            decoration: InputDecoration(
              labelText: 'Qtd.',
              labelStyle: Style.textField
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR", style: Style.closeButton,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ADICIONAR", style: Style.okButton,),
              onPressed: (){
                addItem(item, int.parse(ctrAmount.text));
              },
            ),
          ],
        );
      },
    );
  }

  void _editAddedProduct(p){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Editar Produto Adicionado", style: Style.dialogTitle),
          content: TextField(
            style: Style.textField,
            controller: ctrEdit,
            decoration: InputDecoration(
              labelText: 'Alterar Qtd.'
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR", style: Style.closeButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("EXCLUIR", style: Style.closeButton),
              onPressed: () async {
                await removeItem(p);
                //Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("SALVAR", style: Style.okButton),
              onPressed: (){
                editItem(p);
              },
            ),
          ],
        );
      },
    );
  }

  void _discount() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Desconto", style: Style.dialogTitle),
          content: TextField(
            style: Style.textField,
            controller: ctrDiscount,
            decoration: InputDecoration(
              prefixIcon: Icon(LineIcons.money)
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR", style: Style.closeButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ADICIONAR", style: Style.okButton),
              onPressed: addDiscount,
            ),
          ],
        );
      },
    );
  }

  void _manpower() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Mão de Obra", style: Style.dialogTitle,),
          content: TextField(
            style: Style.textField,
            controller: ctrManPower,
            decoration: InputDecoration(
              prefixIcon: Icon(LineIcons.money)
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("FECHAR", style: Style.closeButton,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ADICIONAR", style: Style.okButton,),
              onPressed: addManPower,
            ),
          ],
        );
      },
    );
  }

  addDiscount() async {
    double discount = double.parse(ctrDiscount.text
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .replaceAll('R\$', '')
        .trim());
    bool res =
        await ServiceService.discount(widget.serviceModel.idServico, discount);

    Navigator.pop(context);
    if (res) {
      Utils.showInSnackBar('Desconto adicionado', Colors.green, _scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar desconto', Colors.red, _scaffoldKey);
    }
  }

  addManPower() async {
    double mdo = double.parse(ctrManPower.text
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .replaceAll('R\$', '')
        .trim());
    bool res =
        await ServiceService.manPower(widget.serviceModel.idServico, mdo);

    Navigator.pop(context);
    if (res) {
      Utils.showInSnackBar(
          'Mão de obra adicionada', Colors.green, _scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar mão de obra', Colors.red, _scaffoldKey);
    }
  }
}
