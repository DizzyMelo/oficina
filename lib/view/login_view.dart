import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/model/user_base_model.dart';
import 'package:oficina/service/user_service.dart';
import 'package:oficina/shared/actives.dart';
import 'package:oficina/shared/style.dart';
import 'package:oficina/shared/utils.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //TextEditingController ctrUser = TextEditingController(text: 'daniel.melo');
  TextEditingController ctrCpf = MaskedTextController(mask: '000.000.000-00', text: '099.281.414-60');
  TextEditingController ctrPass = TextEditingController(text: '102030');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscure = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.primary,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3)
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: ctrCpf,
                style: Style.textField,
                decoration: InputDecoration(
                  prefixIcon: Icon(LineIcons.user, color: Colors.grey[400],),
                  hintText: "Usuário",
                  hintStyle: Style.textField,
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
                obscureText: obscure,
                style: Style.textField,
                decoration: InputDecoration(
                  prefixIcon: Icon(LineIcons.lock, color: Colors.grey[400],),
                  hintText: "Senha",
                  hintStyle: Style.textField,
                  suffixIcon: IconButton(icon: Icon(obscure ? LineIcons.eye : LineIcons.eye_slash), onPressed: changeObscure),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey[800],
                    )
                  )
                ),
              ),

              SizedBox(height: 20),

              loading ?
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Style.secondaryColor),
                ),
              )
              :
              
              InkWell(
                onTap: login,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Style.secondaryColor,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Center(child: Text('ENTRAR', style: Style.mainButtonText,),),
                ),
              ),

              SizedBox(height: 10),

              FlatButton(onPressed: (){}, child: Text('Esqueceu sua senha?', style: Style.secondaryButtonText,))

            ],
          ),
        ),
      ),
    );
  }

  bool validateInfo() {
    if(ctrCpf.text.isEmpty){
      Utils.showInSnackBar('Por favor, informe o nome de usuário', Colors.red, _scaffoldKey);
      return false;
    }else if(ctrPass.text.isEmpty){
      Utils.showInSnackBar('Por favor, informe a senha', Colors.red, _scaffoldKey);
      return false;
    }
    return true;
  }

  changeObscure(){
    setState(() {
      obscure = !obscure;
    });
  }

  login() async {
    if(validateInfo()) {
      setState(() {
        loading = true;
      });
      UserBaseModel user = await UserService.login(ctrCpf.text, ctrPass.text, '');
      setState(() {
        loading = false;
      });
      if(user != null){
        print(user.primeiroNome);
        Active.user = user;
        Navigator.pushNamed(context, '/main', arguments: user);
      }else{
        Utils.showInSnackBar('Usuário ou senha inválidos', Colors.red, _scaffoldKey);
      }
    }

    
  }
}