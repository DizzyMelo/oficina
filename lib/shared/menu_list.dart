import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MenuItem {
  Color color;
  String title;
  IconData icon;
  String screen;
  MenuItem({this.title, this.icon, this.color, this.screen});
}

class MenuList {
  static List<MenuItem> listMenu = [
    MenuItem(color: Colors.blue, title: 'Serviços', icon: LineIcons.wrench, screen: '/new_service'),
    MenuItem(color: Colors.teal, title: 'Clientes', icon: LineIcons.user, screen: '/client'),
    MenuItem(color: Colors.red, title: 'Estoque', icon: LineIcons.square, screen: '/stock'),
    MenuItem(color: Colors.orange, title: 'Colaboradores', icon: LineIcons.wrench, screen: '/worker'),
    
  ];
}