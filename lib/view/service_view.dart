import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/added_item_model.dart';
import 'package:oficina/model/item_model.dart';
import 'package:oficina/model/service_model.dart';
import 'package:oficina/service/item_service.dart';
import 'package:oficina/service/service_service.dart';
import 'package:oficina/shared/print.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ServiceView extends StatefulWidget {
  final ServiceModel serviceModel;

  ServiceView({this.serviceModel});
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  TextEditingController ctrSearch = TextEditingController();
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
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(LineIcons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
            Center(
              child: Container(
                  height: 700,
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
                                        onSubmitted: searchItems,
                                        controller: ctrSearch,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey[400],
                                            ),
                                            hintText: "Buscar Produto ...",
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey[800],
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 400,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemExtent: 45,
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              ItemModel item = items[index];
                                              return ListTile(
                                                onTap: (){
                                                  addItem(item, 2);
                                                },
                                                title: Text(item.nome ?? 'no-data', style: Style.itemNameText),
                                                trailing: Text(Utils.formatMoney(double.parse(item.valorVenda)) ?? 'no-data', style: Style.itemValueText),
                                                subtitle: Text('Qtd.: ${item.qtd} - Qtd. Min.: ${item.qtdMin}' ?? 'no-data', style: Style.itemValueText),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                            Flexible(flex: 1, child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text('Itens Adicionados'),
                                  ),
                                  SizedBox(height: 24,),
                                  Divider(
                                    color: Colors.grey[800],
                                    thickness: 2,
                                  ),
                                  Container(
                                        height: 400,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemExtent: 45,
                                            itemCount: addedItems == null ? 0 : addedItems.produtosAdicionados.length,
                                            itemBuilder: (context, index) {
                                              ProdutosAdicionado p = addedItems.produtosAdicionados[index];
                                              return ListTile(
                                                title: Text(p.nome, style: Style.itemNameText,),
                                                subtitle: Text("(${p.qtd} x ${Utils.formatMoney(double.parse(p.valorVenda))})", style: Style.itemValueText,),
                                                trailing: Text("${Utils.formatMoney(double.parse(p.valorTotal))}", style: Style.itemValueText,),
                                              );
                                            }),
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.grey[300]))),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Desconto:'),
                                              Text(valores == null ? 'no-data' : Utils.formatMoney(double.parse(valores.desconto))),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Mão de obra:'),
                                              Text(valores == null ? 'no-data' : Utils.formatMoney(double.parse(valores.mdo))),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Valor Total:'),
                                              Text(valores == null ? 'no-data' : Utils.formatMoney(double.parse(valores.valorTotal))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey[300]))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.red,
                                        child: Text('Cancelar',
                                            style: Style.serviceButton),
                                        onPressed: () {}),
                                    SizedBox(width: 10),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.green,
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.print,
                                              color: Colors.white,
                                            ),
                                            Text('Imprimir',
                                                style: Style.serviceButton)
                                          ],
                                        ),
                                        onPressed: () {
                                          Printer.print();
                                        }),
                                    SizedBox(width: 10),
                                    RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: Colors.green,
                                        child: Text(
                                          'Concluir',
                                          style: Style.serviceButton,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }

  getAddedItems() async {
    ItemAdicionadoModel tempItems = await ServiceService.getAddedItems(widget.serviceModel.idServico);

    if(tempItems != null){
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });
    }
  }

  addItem(ItemModel item, int qtd) async {
    double valorTotal = double.parse(item.valorVenda) * qtd;
    ItemAdicionadoModel tempItems = await ServiceService.addItem(item, widget.serviceModel.idServico, qtd, valorTotal);

    if(tempItems != null){
      setState(() {
        addedItems = tempItems;
        valores = tempItems.valores;
      });
    }
  }

  searchItems(String txt) async {

    if(txt.length < 3){
      Utils.showInSnackBar('Digite pelo menos três letras', Colors.red, _scaffoldKey);
      return;
    }
    List<ItemModel> tempItems = await ItemService.searchItems('1', txt);

    if(tempItems != null){
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
}
