import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/product_model.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/product_service.dart';
import 'package:oficina/service/worker_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class WorkerView extends StatefulWidget {
  @override
  _WorkerViewState createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone = TextEditingController();
  TextEditingController ctrLogin = TextEditingController();
  TextEditingController ctrFunction = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<WorkerModel> workers = new List();

  WorkerModel selectedWorker;

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
                                  'Telefone', ctrPhone, LineIcons.code),
                              createTextField(
                                  'Login', ctrLogin, LineIcons.wrench),
                              createTextField(
                                  'Função', ctrFunction, LineIcons.wrench),
                              SizedBox(
                                height: 10,
                              ),
                              selectedWorker != null
                                  ? Row(
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
                                                  "Cancelar",
                                                  style: Style.serviceButton,
                                                ),
                                              ],
                                            ),
                                            onPressed: unfillForm),
                                        SizedBox(
                                          width: 10,
                                        ),
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
                                            onPressed: editProduct)
                                      ],
                                    )
                                  : Row(
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
                                  hintText: 'Buscar...',
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
                                itemCount: workers.length,
                                itemBuilder: (context, index) {
                                  WorkerModel w = workers[index];

                                  return ListTile(
                                      onTap: () {
                                        fillForm(w);
                                        setState(() {
                                          selectedWorker = w;
                                        });
                                      },
                                      title: Text(
                                        w.nome ?? '',
                                        style: Style.clientNameText,
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

  searchProducts(String txt) {
    List<WorkerModel> tempWorkers = new List();

    workers.forEach((element) {
      if (element.nome.toLowerCase().contains(txt)) {
        tempWorkers.add(element);
      }
    });
  }

  unfillForm() {
    ctrName.text = '';
    ctrPhone.text = '';
    ctrLogin.text = '';
    ctrFunction.text = '';
    setState(() {
      selectedWorker = null;
    });
  }

  fillForm(WorkerModel w) {
    ctrName.text = w.nome;
    ctrPhone.text = w.telefone;
    ctrLogin.text = w.endereco;
    ctrFunction.text = w.funcaoId;
  }

  addProduct() async {}

  editProduct() async {}

  getWorkers() async {
    List<WorkerModel> w = await WorkerService.getWorkers('1');

    if (w != null) {
      setState(() {
        workers = w;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWorkers();
  }
}
