import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/phone_textfield_component.dart';
import 'package:oficina/components/search_service_row_component.dart';
import 'package:oficina/controller/service_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/report_service_data_model.dart' as rep;
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class EditUserView extends StatefulWidget {
  final User user;

  EditUserView({@required this.user});
  @override
  _EditUserViewState createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  TextEditingController ctrName = TextEditingController();
  MaskedTextController ctrPhone = MaskedTextController(mask: '(00) 00000-0000');
  MaskedTextController ctrPhone2 = MaskedTextController(mask: '(00) 0000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrCpf = MaskedTextController(mask: '000.000.000-00');

  MaskedTextController ctrInitDate = MaskedTextController(mask: '00/00/0000');
  MaskedTextController ctrFinalDate = MaskedTextController(mask: '00/00/0000');

  rep.ReportServiceDataModel report;

  String fileName = "Selecione uma foto";
  List<int> image;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool loadingDelete = false;
  bool loadingSearch = false;

  IconData iconPhone = LineIcons.phone;
  IconData iconPhone2 = LineIcons.phone;

  double containerHeight = 600;
  double containerWidth = 800;

  UserController _userController = UserController();
  ServiceController _serviceController = ServiceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          AppBarComponent(
            icon: LineIcons.plus,
            title: widget.user.role == 'cliente'
                ? 'Editar Cliente'
                : 'Editar Colaborador',
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(5),
            child: Container(
                height: containerHeight,
                width: containerWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      height: containerHeight,
                      width: containerWidth / 2,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                                child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Utils.imageDialog(
                                        '${DotEnv().env['BASE_URL_IMG']}/user/${widget.user.photo}',
                                        context);
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${DotEnv().env['BASE_URL_IMG']}/user/${widget.user.photo}'),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -12,
                                  right: -12,
                                  child: InkWell(
                                    onTap: () {
                                      _pickImage();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Style.secondaryColor),
                                      child: Icon(
                                        LineIcons.camera_retro,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            MainTextFieldComponent(
                              controller: ctrName,
                              icon: LineIcons.user,
                              hint: 'Nome',
                              mandatory: true,
                            ),
                            MainTextFieldComponent(
                                controller: ctrCpf,
                                icon: LineIcons.user,
                                hint: 'CPF'),
                            PhoneTextFieldComponent(
                              controller: ctrPhone,
                              icon: iconPhone,
                              hint: 'Contato 1',
                              function: changeMaskPhone,
                              mandatory: true,
                            ),
                            PhoneTextFieldComponent(
                              controller: ctrPhone2,
                              icon: iconPhone2,
                              hint: 'Contato 2',
                              function: changeMaskPhone2,
                            ),
                            MainTextFieldComponent(
                                controller: ctrEmail,
                                icon: LineIcons.envelope_o,
                                hint: 'Email'),
                            SizedBox(
                              height: 10,
                            ),
                            FlatButton(
                              onPressed: () {
                                _pickImage();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    LineIcons.camera_retro,
                                    color: Style.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(fileName)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.user.role != 'cliente'
                                ? SizedBox(
                                    height: 1,
                                  )
                                : FlatButton(
                                    onPressed: () {
                                      Client c = Client(
                                          id: widget.user.id,
                                          name: widget.user.name);
                                      Navigator.pushNamed(context, '/new_car',
                                          arguments: c);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          LineIcons.car,
                                          color: Style.primaryColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Veículos')
                                      ],
                                    )),
                            Expanded(child: Container()),
                            loading
                                ? Center(
                                    child: LoadingComponent(),
                                  )
                                : MainButtomComponent(
                                    title: 'SALVAR', function: edit),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // loadingDelete
                            //     ? Center(
                            //         child: LoadingComponent(
                            //           delete: true,
                            //         ),
                            //       )
                            //     : CancelButtomComponent(
                            //         title: 'EXCLUIR', function: delete)
                          ]),
                    ),
                    Container(
                      height: containerHeight,
                      width: containerWidth / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 0.5, color: Colors.grey[800]))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: containerWidth / 4 - 20,
                                child: MainTextFieldComponent(
                                    controller: ctrInitDate,
                                    icon: LineIcons.calendar,
                                    hint: 'Data Inicial'),
                              ),
                              Container(
                                width: containerWidth / 4 - 20,
                                child: MainTextFieldComponent(
                                    controller: ctrFinalDate,
                                    icon: LineIcons.calendar,
                                    hint: 'Data Final'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          loadingSearch
                              ? LoadingComponent()
                              : MainButtomComponent(
                                  title: 'BUSCAR SERVIÇOS',
                                  function: getReport),
                          Expanded(
                            child: report == null || report.results == 0
                                ? Center(
                                    child: Text('Nenhum serviço a ser exibido'),
                                  )
                                : ListView.builder(
                                    itemCount: report.results,
                                    itemBuilder: (context, index) {
                                      rep.Service service =
                                          report.data.services[index];
                                      return SearchServiceRowComponent(
                                        service: service,
                                      );
                                    }),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ]),
      ),
    );
  }

  bool validateInfo() {
    if (ctrName.text.isEmpty) {
      Utils.showMessage('Informe o nome do cliente', context);
      return false;
    } else if (ctrPhone.text.isEmpty) {
      Utils.showMessage(
          'Informe ao menos o primeiro número de contato', context);
      return false;
    }

    return true;
  }

  edit() async {
    if (!validateInfo()) return;

    Map<String, dynamic> data = Utils.validateUserData({
      "name": ctrName.text,
      "email": ctrEmail.text,
      "cpfcnpj": Utils.removeSpecialCharacters(ctrCpf.text),
      "primaryphone": Utils.removeSpecialCharacters(ctrPhone.text),
      "secondaryphone": Utils.removeSpecialCharacters(ctrPhone2.text),
    });

    this.changeLoadingState();
    await _userController.edit(data, widget.user.id, image, fileName, context);
    this.changeLoadingState();
  }

  validateDates() {
    try {
      DateTime.parse(Utils.formatDateReverse(ctrInitDate.text));
      DateTime.parse("${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00");

      return true;
    } catch (e) {
      Utils.showMessage('Data inválida', context);
      return false;
    }
  }

  getReport() async {
    if (!validateDates()) return;
    String userType = widget.user.role == 'cliente' ? 'client' : 'colaborator';
    Map<String, dynamic> data = {
      "shop": SessionVariables.userDataModel.data.data.shop.id,
      userType: widget.user.id,
      "date": {
        "\$gte": Utils.formatDateReverse(ctrInitDate.text),
        "\$lte": "${Utils.formatDateReverse(ctrFinalDate.text)} 24:00:00"
      }
    };
    setState(() {
      loadingSearch = true;
    });
    rep.ReportServiceDataModel res =
        await _serviceController.report(data, context);

    setState(() {
      loadingSearch = false;
    });

    if (res != null) {
      setState(() {
        report = res;
      });
    }
  }

  // delete() async {
  //   Map<String, dynamic> data = {
  //     "active": false,
  //   };
  //   this.changeLoadingDeleteState();
  //   await _userController.edit(data, widget.user.id, true, _scaffoldKey);
  //   this.changeLoadingDeleteState();
  // }

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

  changeMaskPhone(String str) {
    if (str.isEmpty) {
      setState(() {
        iconPhone = LineIcons.phone;
      });
    }
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        ctrPhone.mask = '(00) 0000-0000';
        setState(() {
          iconPhone = LineIcons.phone;
        });
      } else {
        ctrPhone.mask = '(00) 00000-0000';
        setState(() {
          iconPhone = LineIcons.mobile;
        });
      }
    }
  }

  changeMaskPhone2(String str) {
    if (str.isEmpty) {
      setState(() {
        iconPhone2 = LineIcons.phone;
      });
    }
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        ctrPhone2.mask = '(00) 0000-0000';
        setState(() {
          iconPhone2 = LineIcons.phone;
        });
      } else {
        ctrPhone2.mask = '(00) 00000-0000';
        setState(() {
          iconPhone2 = LineIcons.mobile;
        });
      }
    }
  }

  _pickImage() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            image = reader.result;
            fileName = file.name;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            fileName = "Algo deu errado ao ler o arquivo";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ctrName.text = widget.user.name;
    ctrCpf.text = widget.user.cpfcnpj;
    ctrEmail.text = widget.user.email;
    ctrPhone.text = widget.user.primaryphone;
    ctrPhone2.text = widget.user.secondaryphone;

    ctrInitDate.text = Utils.getCurrentDate(days: -7);
    ctrFinalDate.text = Utils.getCurrentDate();
  }
}
