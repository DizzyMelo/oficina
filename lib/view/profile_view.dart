import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/phone_textfield_component.dart';
import 'package:oficina/controller/shop_controller.dart';
import 'package:oficina/controller/user_controller.dart';
import 'package:oficina/model/get_user_data_model.dart';
import 'package:oficina/shared/session_variables.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ctrName = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrCpf = TextEditingController();
  TextEditingController ctrPrimaryPhone = TextEditingController();
  TextEditingController ctrSecondary = TextEditingController();

  TextEditingController ctrPass = TextEditingController();
  TextEditingController ctrPassConfirm = TextEditingController();

  TextEditingController ctrShopName = TextEditingController();
  TextEditingController ctrShopEmail = TextEditingController();
  TextEditingController ctrShopAddress = TextEditingController();
  MaskedTextController ctrShopPrimaryPhone =
      MaskedTextController(mask: '(00) 00000-0000');
  MaskedTextController ctrShopSecondaryPhone =
      MaskedTextController(mask: '(00) 00000-0000');

  ShopController _shopController = ShopController();
  UserController _userController = UserController();

  double containerHeight = 500;
  double containerWidth = 800;

  bool loadingEditShop = false;
  bool loadingEditUser = false;
  bool loadingEditPass = false;

  IconData iconPhone = LineIcons.phone;
  IconData iconPhone2 = LineIcons.phone;

  GetUserDataModel _userDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarComponent(
              icon: LineIcons.user,
              title: 'Perfil',
            ),
            SizedBox(
              height: 30,
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
                        children: [
                          MainTextFieldComponent(
                            controller: ctrName,
                            icon: LineIcons.user,
                            hint: 'Nome do usuário',
                            mandatory: true,
                          ),
                          MainTextFieldComponent(
                              controller: ctrCpf,
                              icon: LineIcons.user,
                              hint: 'CPF/CNPJ'),
                          MainTextFieldComponent(
                              controller: ctrEmail,
                              icon: LineIcons.envelope_o,
                              hint: 'E-mail'),
                          MainTextFieldComponent(
                            controller: ctrPrimaryPhone,
                            icon: LineIcons.phone,
                            hint: 'Contato 1',
                            mandatory: true,
                          ),
                          MainTextFieldComponent(
                              controller: ctrPrimaryPhone,
                              icon: LineIcons.phone,
                              hint: 'Contato 2'),
                          SizedBox(
                            height: 10,
                          ),
                          MainButtomComponent(
                              title: 'SALVAR', function: editUser),
                          SizedBox(
                            height: 20,
                          ),
                          MainTextFieldComponent(
                              controller: ctrPass,
                              icon: LineIcons.lock,
                              hint: 'Senha'),
                          MainTextFieldComponent(
                              controller: ctrPassConfirm,
                              icon: LineIcons.lock,
                              hint: 'Confirmar Senha'),
                          Expanded(child: Container()),
                          MainButtomComponent(
                              title: 'ALTERAR SENHA', function: () {}),
                        ],
                      ),
                    ),
                    Container(
                      height: containerHeight,
                      width: containerWidth / 2,
                      padding: EdgeInsets.all(10),
                      decoration: Style.containerSeparator,
                      child: Column(
                        children: [
                          MainTextFieldComponent(
                            controller: ctrShopName,
                            icon: LineIcons.user,
                            hint: 'Nome da Loja',
                            mandatory: true,
                          ),
                          MainTextFieldComponent(
                              controller: ctrShopAddress,
                              icon: LineIcons.user,
                              hint: 'Endereço da loja'),
                          MainTextFieldComponent(
                              controller: ctrShopEmail,
                              icon: LineIcons.envelope_o,
                              hint: 'E-mail loja'),
                          PhoneTextFieldComponent(
                            controller: ctrShopPrimaryPhone,
                            icon: iconPhone,
                            hint: 'Contato 1',
                            function: changeMaskPhone,
                            mandatory: true,
                          ),
                          PhoneTextFieldComponent(
                            controller: ctrShopSecondaryPhone,
                            icon: iconPhone2,
                            hint: 'Contato 2',
                            function: changeMaskPhone2,
                          ),
                          Expanded(child: Container()),
                          loadingEditShop
                              ? LoadingComponent()
                              : MainButtomComponent(
                                  title: 'SALVAR',
                                  function: SessionVariables
                                              .userDataModel.data.data.role !=
                                          'admin'
                                      ? editShop
                                      : null),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String setMaskPhone(String str) {
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        return '(00) 0000-0000';
      } else {
        return '(00) 00000-0000';
      }
    } else {
      return '(00) 00000-0000';
    }
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
        ctrShopPrimaryPhone.mask = '(00) 0000-0000';
        setState(() {
          iconPhone = LineIcons.phone;
        });
      } else {
        ctrShopPrimaryPhone.mask = '(00) 00000-0000';
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
        ctrShopSecondaryPhone.mask = '(00) 0000-0000';
        setState(() {
          iconPhone2 = LineIcons.phone;
        });
      } else {
        ctrShopSecondaryPhone.mask = '(00) 00000-0000';
        setState(() {
          iconPhone2 = LineIcons.mobile;
        });
      }
    }
  }

  editShop() async {
    Map<String, dynamic> data = {
      "name": ctrShopName.text,
      "email": ctrShopEmail.text,
      "address": ctrShopAddress.text,
      "primaryphone": ctrShopPrimaryPhone.text,
      "secondaryphone": ctrShopSecondaryPhone.text
    };
    setState(() {
      loadingEditShop = !loadingEditShop;
    });
    await _shopController.edit(data, _scaffoldKey);
    setState(() {
      loadingEditShop = !loadingEditShop;
    });
  }

  editUser() async {
    Map<String, dynamic> data = {
      "name": ctrName.text,
      "email": ctrEmail.text,
      "cpfcnpj": ctrCpf.text,
      "primaryphone": ctrPrimaryPhone.text,
      "secondaryphone": ctrSecondary.text
    };
    setState(() {
      loadingEditUser = !loadingEditUser;
    });
    await _userController.edit(
        data, SessionVariables.userDataModel.data.data.id, false, _scaffoldKey);

    await this.getUserInformation();
    setState(() {
      loadingEditUser = !loadingEditUser;
    });
  }

  getUserInformation() async {
    GetUserDataModel res = await _userController.getUserInformation(
        SessionVariables.userDataModel.data.data.id, context, _scaffoldKey);

    if (res != null) {
      setState(() {
        _userDataModel = res;
      });

      ctrName.text = _userDataModel.data.data.name;
      ctrCpf.text = _userDataModel.data.data.cpfcnpj;
      ctrEmail.text = _userDataModel.data.data.email;
      ctrPrimaryPhone.text = _userDataModel.data.data.primaryphone;
      ctrSecondary.text = _userDataModel.data.data.secondaryphone;

      ctrShopName.text = _userDataModel.data.data.shop.name;
      ctrShopAddress.text = _userDataModel.data.data.shop.address;
      ctrShopEmail.text = _userDataModel.data.data.shop.email;

      ctrShopPrimaryPhone.mask = setMaskPhone(
          Utils.clearPhone(_userDataModel.data.data.shop.primaryphone));

      ctrShopSecondaryPhone.mask = setMaskPhone(
          Utils.clearPhone(_userDataModel.data.data.shop.primaryphone));

      ctrShopPrimaryPhone.text = _userDataModel.data.data.shop.primaryphone;
      ctrShopSecondaryPhone.text = _userDataModel.data.data.shop.secondaryphone;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUserInformation();
  }
}
