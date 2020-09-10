import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/phone_textfield_component.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
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

  MaskedTextController ctrInitDate = MaskedTextController(mask: '00/00/00');
  MaskedTextController ctrFinalDate = MaskedTextController(mask: '00/00/00');

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool loadingDelete = false;

  IconData iconPhone = LineIcons.phone;
  IconData iconPhone2 = LineIcons.phone;

  double containerHeight = 500;
  double containerWidth = 800;

  UserController _userController;
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
                            MainTextFieldComponent(
                              controller: ctrName,
                              icon: LineIcons.user,
                              hint: 'Nome',
                              mandatory: true,
                            ),
                            MainTextFieldComponent(
                                controller: ctrCpf,
                                icon: LineIcons.user,
                                hint: 'CPF/CNPJ'),
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
                            Expanded(child: Container()),
                            loading
                                ? Center(
                                    child: LoadingComponent(),
                                  )
                                : MainButtomComponent(
                                    title: 'SALVAR', function: edit),
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
                          Expanded(
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      'Celta Prisma 2009',
                                      style: Style.mainClientNameText,
                                    ),
                                    subtitle: Text(
                                      'Gilvan Silva',
                                      style: Style.carNameText,
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Utils.formatMoney(400),
                                          style: Style.totalValueText,
                                        ),
                                        Text(
                                          '20/20/2020',
                                          style: Style.phoneText,
                                        ),
                                      ],
                                    ),
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
      Utils.showInSnackBar(
          'Informe o nome do cliente', Colors.red, _scaffoldKey);
      return false;
    } else if (ctrPhone.text.isEmpty) {
      Utils.showInSnackBar('Informe ao menos o primeiro número de contato',
          Colors.red, _scaffoldKey);
      return false;
    }

    return true;
  }

  edit() async {
    if (!validateInfo()) return;

    Map<String, dynamic> data = Utils.validateUserData({
      "name": ctrName.text,
      "email": ctrEmail.text,
      "cpfcnpj": ctrCpf.text,
      "primaryphone": ctrPhone.text,
      "secondaryphone": ctrPhone2.text,
    });

    this.changeLoadingState();
    await _userController.edit(
        data, widget.user.id, false, context, _scaffoldKey);
    this.changeLoadingState();
  }

  delete() async {
    Map<String, dynamic> data = {
      "active": false,
    };
    this.changeLoadingDeleteState();
    await _userController.edit(
        data, widget.user.id, true, context, _scaffoldKey);
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

  @override
  void initState() {
    super.initState();
    ctrName.text = widget.user.name;
    ctrCpf.text = widget.user.cpfcnpj;
    ctrEmail.text = widget.user.email;
    ctrPhone.text = widget.user.primaryphone;
    ctrPhone2.text = widget.user.secondaryphone;

    _userController = UserController();
  }
}
