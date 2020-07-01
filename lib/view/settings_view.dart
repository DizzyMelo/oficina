import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_component.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          AppBarComponent(icon: LineIcons.gear, title: 'Configurações',),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 500,
              height: 600,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Dias Serviço ativo',
                      suffixIcon: IconButton(icon: Icon(LineIcons.info_circle), onPressed: (){})
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
