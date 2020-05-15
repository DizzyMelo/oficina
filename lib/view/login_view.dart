import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/user_model.dart';
import 'package:oficina/service/user_service.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController ctrUser = TextEditingController(text: 'daniel.melo');
  TextEditingController ctrPass = TextEditingController(text: 'mo123');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.primary,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3)
          ),

          child: Column(
            children: [

              TextField(
                controller: ctrUser,
                decoration: InputDecoration(
                  prefixIcon: Icon(LineIcons.user, color: Colors.grey[400],),
                  hintText: "Usuário",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey[800],
                    )
                  )
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: ctrPass,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(LineIcons.lock, color: Colors.grey[400],),
                  hintText: "Senha",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey[800],
                    )
                  )
                ),
              ),

              SizedBox(height: 20),

              RaisedButton(
                child: Text("Entrar"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)
                ),
                onPressed: login)

            ],
          ),
        ),
      ),
    );
  }

  bool validateInfo() {
    if(ctrUser.text.isEmpty){
      Utils.showInSnackBar('Por favor, informe o nome de usuário', Colors.red, _scaffoldKey);
      return false;
    }else if(ctrPass.text.isEmpty){
      Utils.showInSnackBar('Por favor, informe a senha', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  login() async {
    if(validateInfo()) {
      UserModel user = await UserService.login(ctrUser.text, ctrPass.text);
      if(user != null){
        Navigator.pushNamed(context, '/main', arguments: user);
      }else{
        Utils.showInSnackBar('Usuário ou senha inválidos', Colors.red, _scaffoldKey);
      }
    }

    
  }
}