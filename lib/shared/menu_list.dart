import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MenuItem {
  Color color;
  String title;
  IconData icon;
  String screen, img;
  MenuItem({this.title, this.icon, this.color, this.screen, this.img});
}

class MenuList {
  static List<MenuItem> listMenu = [
    MenuItem(
        color: Colors.blue,
        title: 'Novo Serviço',
        icon: LineIcons.plus,
        screen: '/select_client',
        img: 'plus.png'),
    MenuItem(
        color: Colors.teal,
        title: 'Clientes',
        icon: LineIcons.user,
        screen: '/client',
        img: 'client.png'),
    MenuItem(
        color: Colors.red,
        title: 'Estoque',
        icon: LineIcons.square,
        screen: '/stock',
        img: 'stock.png'),
    MenuItem(
        color: Colors.orange,
        title: 'Colaboradores',
        icon: LineIcons.wrench,
        screen: '/worker',
        img: 'mechanic.png'),
    MenuItem(
        color: Colors.orange,
        title: 'Configurações',
        icon: LineIcons.gear,
        screen: '/settings',
        img: 'settings.png'),
  ];
}
