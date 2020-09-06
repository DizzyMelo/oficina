import 'dart:html';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oficina/components/appbar_revert_component.dart';
import 'package:oficina/shared/style.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.secondaryColor,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppBarRevertComponent(
              icon: LineIcons.user,
              title: 'Perfil',
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text('Daniel Freitas'),
                    subtitle: Text('usuário'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
