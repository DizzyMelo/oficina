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

  //New Service Page

  static TextStyle clientNameText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle carText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400, fontSize: 13));
  static TextStyle workerNameServiceText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle selectWorkerTitle = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15));

  // Stock Page

  static TextStyle qtdOkText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: 13));
  static TextStyle qtdOkWarning = GoogleFonts.lato(textStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.w800, fontSize: 13));
  static TextStyle qtdOkDanger = GoogleFonts.lato(textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 13));

  static TextStyle labelValueText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valuePaidText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valueSaleText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valueProfitText = GoogleFonts.lato(textStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700, fontSize: 12));
}