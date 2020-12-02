import 'package:flutter/material.dart';
import 'package:oficina/components/logo_component.dart';
import 'package:oficina/controller/auth_controller.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthController _controller = AuthController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LogoComponent(
          height: 100,
          width: 100,
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 400,
          child: LinearProgressIndicator(),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.checkLoggedIn(context);
  }
}
