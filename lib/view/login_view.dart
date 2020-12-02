import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/logo_component.dart';
import 'package:oficina/components/main_buttom_component.dart';
import 'package:oficina/components/main_textfield_component.dart';
import 'package:oficina/controller/auth_controller.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController ctrCpf = TextEditingController();
  TextEditingController ctrPass = TextEditingController();

  AuthController _controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          elevation: 10,
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 400,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoComponent(),
                Column(
                  children: [
                    MainTextFieldComponent(
                        controller: ctrCpf,
                        icon: LineIcons.user,
                        hint: 'CPF ou Telefone (com DDD)'),
                    SizedBox(height: 10),
                    Observer(
                      builder: (_) => TextField(
                        controller: ctrPass,
                        obscureText: _controller.obscure,
                        style: Style.textField,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.grey[400],
                          ),
                          labelText: "Senha",
                          labelStyle: Style.textField,
                          suffixIcon: IconButton(
                              icon: Icon(_controller.obscure
                                  ? LineIcons.eye
                                  : LineIcons.eye_slash),
                              onPressed: _controller.changeObscure),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (_) => MainButtomComponent(
                    title: 'ENTRAR',
                    function: () {
                      _controller.login(ctrCpf.text, ctrPass.text, context);
                    },
                    loading: _controller.loading,
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      Utils.showMessage(
                          'Funcionalidade em desenvolvimento!', context,
                          width: 300);
                    },
                    child: Text(
                      'Esqueceu sua senha?',
                      style: Style.secondaryButtonText,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
