import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/worker_model.dart';
import 'package:oficina/service/worker_service.dart';
import 'package:oficina/shared/style.dart';

class NewServiceView extends StatefulWidget {
  @override
  _NewServiceViewState createState() => _NewServiceViewState();
}

class _NewServiceViewState extends State<NewServiceView> {
  TextEditingController ctrSearch = TextEditingController();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrPlate = MaskedTextController(mask: '***-0*00');

  List<WorkerModel> workers = new List();

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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            createTextField('Nome', ctrName, LineIcons.user),
                            createTextField(
                                'Telefone', ctrPhone, LineIcons.phone),
                            createTextField(
                                'Email', ctrEmail, LineIcons.envelope_o),
                            createTextField('Carro', ctrCar, LineIcons.car),
                            createTextField(
                                'Placa', ctrPlate, LineIcons.square_o),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  LineIcons.wrench,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Colaborador',
                                  style: Style.textField,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
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
                                    onPressed: () {}),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          LineIcons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Iniciar",
                                          style: Style.serviceButton,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {}),
                              ],
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                          child: Column(
                        children: [
                          Text('COLABORADOR RESPONSÁVEL'),
                          Divider(
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Expanded(child: Container(child: ListView.builder(
                              itemCount: workers.length,
                              itemBuilder: (context, index){

                                WorkerModel workerModel = workers[index];
                                return ListTile(
                                  title: Text(workerModel.nome),
                                );
                              },
                            ),))
                        ],
                      ))),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            TextField(
                              style: Style.textField,
                              controller: ctrSearch,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    LineIcons.search,
                                    size: 20,
                                    color: Colors.grey[400],
                                  ),
                                  hintText: 'Buscar cliente...',
                                  hintStyle: Style.textField,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[800],
                                  ))),
                            ),

                            SizedBox(height: 10,),

                            Expanded(child: Container(child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index){
                                return ListTile(
                                  title: Text('Cliente'),
                                );
                              },
                            ),))
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

  getWorkers() async {
    List<WorkerModel> wk = await WorkerService.getWorkers('1');

    //print(wk.length);
    if(wk != null && wk.length > 0){
      setState(() {
        workers = wk;
      });
    }
  }

  @override
  void initState() { 
    super.initState();
    this.getWorkers();
  }
}
