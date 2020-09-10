import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';
import 'package:oficina/components/loading_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/components/phone_textfield_component.dart';
import 'package:oficina/controller/shop_controller.dart';
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
  MaskedTextController ctrShopPrimaryPhone = MaskedTextController();
  MaskedTextController ctrShopSecondaryPhone = MaskedTextController();

  ShopController _shopController = ShopController();

  double containerHeight = 500;
  double containerWidth = 800;

  bool loadingEditShop = false;
  bool loadingEditUser = false;
  bool loadingEditPass = false;

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
                          MainButtomComponent(title: 'SALVAR', function: () {}),
                          SizedBox(
                            height: 20,
                          ),
                          MainTextFieldComponent(
                              controller: ctrPrimaryPhone,
                              icon: LineIcons.lock,
                              hint: 'Senha'),
                          MainTextFieldComponent(
                              controller: ctrPrimaryPhone,
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
                            icon: LineIcons.phone,
                            hint: 'Contato 1',
                            function: (e) {},
                            mandatory: true,
                          ),
                          MainTextFieldComponent(
                              controller: ctrShopSecondaryPhone,
                              icon: LineIcons.phone,
                              hint: 'Contato 2'),
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
    print(str);
    if (str.length >= 4) {
      String txt = Utils.clearPhone(str);
      int number = int.parse(txt.substring(3, 4));
      if (number < 6) {
        print('tel');
        return '(00) 0000-0000';
      } else {
        print('cel');
        return '(00) 00000-0000';
      }
    } else {
      print('cel*');
      return '(00) 00000-0000';
    }
  }

  // changeMaskPhone(String str) {
  //   if (str.isEmpty) {
  //     setState(() {
  //       iconPhone = LineIcons.phone;
  //     });
  //   }
  //   if (str.length >= 4) {
  //     String txt = Utils.clearPhone(str);
  //     int number = int.parse(txt.substring(3, 4));
  //     if (number < 6) {
  //       ctrPhone.mask = '(00) 0000-0000';
  //       setState(() {
  //         iconPhone = LineIcons.phone;
  //       });
  //     } else {
  //       ctrPhone.mask = '(00) 00000-0000';
  //       setState(() {
  //         iconPhone = LineIcons.mobile;
  //       });
  //     }
  //   }
  // }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ctrShopName.text = SessionVariables.userDataModel.data.data.shop.name;
    ctrShopAddress.text = SessionVariables.userDataModel.data.data.shop.address;
    ctrShopEmail.text = SessionVariables.userDataModel.data.data.shop.email;

    ctrShopPrimaryPhone.mask = setMaskPhone(Utils.clearPhone(
        SessionVariables.userDataModel.data.data.shop.primaryphone));

    ctrShopPrimaryPhone.text =
        SessionVariables.userDataModel.data.data.shop.primaryphone;
    ctrShopSecondaryPhone.text =
        SessionVariables.userDataModel.data.data.shop.secondaryphone;
  }
}
