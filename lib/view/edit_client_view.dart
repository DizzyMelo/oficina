import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/cancel_buttom_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/controller/product_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/search_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/utils.dart';

class EditClientView extends StatefulWidget {
  final User user;

  EditClientView({@required this.user});
  @override
  _EditClientViewState createState() => _EditClientViewState();
}

class _EditClientViewState extends State<EditClientView> {
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrPhone =
      MaskedTextController(mask: '(00) 00000-0000');

  TextEditingController ctrPhone2 =
      MaskedTextController(mask: '(00) 0000-0000');
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCar = TextEditingController();
  TextEditingController ctrCpf = MaskedTextController(mask: '000.000.000-00');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool loadingDelete = false;

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
            title: 'Editar Cliente',
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
                        hint: 'Nome'),
                    MainTextFieldComponent(
                        controller: ctrCpf,
                        icon: LineIcons.user,
                        hint: 'CPF/CNPJ'),
                    MainTextFieldComponent(
                        controller: ctrPhone,
                        icon: LineIcons.phone,
                        hint: 'Celular'),
                    MainTextFieldComponent(
                        controller: ctrPhone2,
                        icon: LineIcons.phone,
                        hint: 'Telefone Fixo'),
                    MainTextFieldComponent(
                        controller: ctrEmail,
                        icon: LineIcons.envelope_o,
                        hint: 'Email'),
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
      "email": ctrEmail.text,
      "cpfcnpj": ctrCpf.text
    };
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
