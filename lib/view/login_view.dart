import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/service/user_service.dart';
import 'package:oficina/shared/style.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController ctrUser = TextEditingController(text: 'daniel.melo');
  TextEditingController ctrPass = TextEditingController(text: 'mo123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      print("usuario vazio");
      return false;
    }else if(ctrPass.text.isEmpty){
      print("senha vazio");
      return false;
    }
    return true;
  }

  login() async {
    if(validateInfo() == false) return;

    UserService.login(ctrUser.text, ctrPass.text);

    // Map<String, dynamic> args = {
    //                 'numero': 8
    //               };
    //               Navigator.pushNamed(context, '/main', arguments: "teste de argumento");

  }
}