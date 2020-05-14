import 'package:flutter/material.dart';
import 'package:oficina/shared/style.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.grey[400],),
                  hintText: "E-mail",
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
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.grey[400],),
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
                onPressed: (){
                  Navigator.pushNamed(context, '/main');
                
              })

            ],
          ),
        ),
      ),
    );
  }
}