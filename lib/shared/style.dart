import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static Color primary = new Color.fromRGBO(0, 153, 255, 1);




  static TextStyle loginButton = TextStyle(color: Colors.grey[600]);
  static TextStyle serviceButton = GoogleFonts.lato(textStyle: TextStyle(color: Colors.white));
  static TextStyle welcomeText = TextStyle(color: Colors.white, fontSize: 20);

  static TextStyle itemNameText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle itemValueText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 12));
  static TextStyle mediumText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 14));

  static TextStyle valueTitleText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle valueText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));

  static TextStyle textField = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));

  //Main Page
  static TextStyle mainClientNameText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle workerNameText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 12));
}