import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/role_model.dart';
import 'package:oficina/components/worker_row_component.dart';
import 'package:oficina/model/worker_model.dart';
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
  List<RoleModel> roles = new List();

  WorkerModel selectedWorker;
  int index = 0;
  String selectedRole;

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
            AppBarComponent(
              icon: LineIcons.wrench,
              title: 'Colaboradores',
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
                                  'Telefone', ctrPhone, LineIcons.phone),
                              createTextField(
                                  'Login', ctrLogin, LineIcons.wrench),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Função',
                                    style: Style.carTextTitle,
                                  )),
                                  Flexible(
                                      child: DropdownButton<String>(
                                    items: roles
                                        .map((role) => DropdownMenuItem(
                                            value: role.id.toString(),
                                            child: Text(
                                              role.funcao,
                                              style: Style.carTextTitle,
                                            )))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRole = value;
                                      });
                                    },
                                    value: selectedRole,
                                    isExpanded: true,
                                  ))
                                ],
                              ),
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
                                                  "Excluir",
                                                  style: Style.serviceButton,
                                                ),
                                              ],
                                            ),
                                            onPressed: _deleteWorker),
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
                                            onPressed: addWorker),
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
                                        child: Scrollbar(
                                            child: ListView.builder(
                                                itemExtent: 55,
                                                itemCount: workers.length,
                                                itemBuilder: (context, i) {
                                                  WorkerModel worker =
                                                      workers[i];
                                                  return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedWorker =
                                                              worker;
                                                          index = i;
                                                        });
                                                      },
                                                      child: WorkerRowComponent(
                                                          worker));
                                                })))))
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

  editProduct() async {}

  getWorkers() async {
    List<WorkerModel> w = await WorkerService.getWorkers('1');

    if (w != null) {
      setState(() {
        workers = w;
      });
    }
  }

  getRoles() async {
    List<RoleModel> r = await WorkerService.getRoles('1');

    if (r != null) {
      setState(() {
        roles = r;
        selectedRole = r.first.id;
      });
    }
  }

  bool validateInfo() {
    if (ctrName.text.isEmpty) {
      Utils.showInSnackBar(
          'Digie o nome do colaborador', Colors.red, _scaffoldKey);
      return false;
    } else if (selectedRole == null || selectedRole.isEmpty) {
      Utils.showInSnackBar(
          'Selecione a função do colaborador', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  _deleteWorker() async {
    WorkerModel w = await WorkerService.deleteWorker(selectedWorker.id);
    if (w != null) {

      Utils.showInSnackBar('Colaborador excluido com sucesso', Colors.green, _scaffoldKey);
      setState(() {
        workers.removeAt(index);
      });
    }
  }

  addWorker() async {
    if (validateInfo() == false) return;
    WorkerModel w = await WorkerService.addWorker(
        ctrName.text, ctrPhone.text, '', '1', selectedRole, ctrLogin.text);

    if (w != null) {
      setState(() {
        workers.add(w);
      });
      Utils.showInSnackBar(
          'Colaborador adicionado', Colors.green, _scaffoldKey);
    } else {
      Utils.showInSnackBar(
          'Erro ao adicionar colaborador', Colors.red, _scaffoldKey);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWorkers();
    this.getRoles();
  }
}
