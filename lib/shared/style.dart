import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static Map<int, Color> colorCodes = {
    50: Color.fromRGBO(105, 231, 129, .1),
    100: Color.fromRGBO(105, 231, 129, .2),
    200: Color.fromRGBO(105, 231, 129, .3),
    300: Color.fromRGBO(105, 231, 129, .4),
    400: Color.fromRGBO(105, 231, 129, .5),
    500: Color.fromRGBO(105, 231, 129, .6),
    600: Color.fromRGBO(105, 231, 129, .7),
    700: Color.fromRGBO(105, 231, 129, .8),
    800: Color.fromRGBO(105, 231, 129, .9),
    900: Color.fromRGBO(105, 231, 129, 1),
  };

  static MaterialColor themeColor = MaterialColor(0xFF69E781, colorCodes);

  static Color primary = new Color.fromRGBO(105, 231, 129, 1);

  static Color primaryColor = Color.fromRGBO(105, 231, 129, 1);
  static Color secondaryColor = Color.fromRGBO(55, 73, 87, 1);

  static TextStyle loginButton = TextStyle(color: Colors.grey[600]);
  static TextStyle serviceButton =
      GoogleFonts.lato(textStyle: TextStyle(color: Colors.white));

  static TextStyle mainButtonText = GoogleFonts.lato(
      textStyle: TextStyle(color: secondaryColor, fontSize: 15));

  static TextStyle whiteButtonText =
      GoogleFonts.lato(textStyle: TextStyle(color: Colors.white, fontSize: 15));

  static TextStyle secondaryButtonText = GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.grey[700], fontSize: 13));
  static TextStyle welcomeText = TextStyle(color: Colors.white, fontSize: 20);

  static TextStyle itemNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle itemValueText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 12));
  static TextStyle paymenyDateText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 10));
  static TextStyle mediumText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 14));

  static TextStyle valueTitleText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle valueText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 12));

  static TextStyle textField = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w400, fontSize: 13));

  static TextStyle textFieldMandatory = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w400,
          fontSize: 11,
          fontStyle: FontStyle.italic));

  static TextStyle pageTitleText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 17));

  static TextStyle pageTitleTextRevert = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[100], fontWeight: FontWeight.w600, fontSize: 17));

  //Main Page
  static TextStyle mainClientNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle carNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w500, fontSize: 11));
  static TextStyle workerNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 11));

  static TextStyle optionTitleText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[900], fontWeight: FontWeight.w400, fontSize: 13));

  static TextStyle optionTitleTextLight = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[100], fontWeight: FontWeight.w400, fontSize: 13));

  static TextStyle userNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[100], fontWeight: FontWeight.w400, fontSize: 13));
  static TextStyle shopNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[100], fontWeight: FontWeight.w400, fontSize: 15));
  static TextStyle totalValueText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.w700, fontSize: 11));
  static TextStyle mdoText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[500], fontWeight: FontWeight.w700, fontSize: 11));
  static TextStyle phoneText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 11));
  static TextStyle plateText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 11));
  static TextStyle selectedGroupServiceText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle unselectedGroupServiceText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle searchText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 12));
  static TextStyle messageText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 12));

  static TextStyle menuItemText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13));

  //New Service Page

  static TextStyle clientNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 12));
  static TextStyle carText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 11));
  static TextStyle workerNameServiceText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 12));
  static TextStyle workerRoleSubtitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w500, fontSize: 11));
  static TextStyle selectWorkerTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15));
  static TextStyle paymentFormatTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13));

  static TextStyle serviceMessage = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 12));

  //Client Page

  static TextStyle clientTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 15));
  static TextStyle carTextTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 13));
  static TextStyle notFoundTextTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 15));

  // Stock Page

  static TextStyle qtdOkText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.w800, fontSize: 13));
  static TextStyle qtdOkWarning = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.orange, fontWeight: FontWeight.w800, fontSize: 13));
  static TextStyle qtdOkDanger = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.red, fontWeight: FontWeight.w800, fontSize: 13));

  static TextStyle labelValueText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[700], fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valuePaidText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.red, fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valueSaleText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle valueProfitText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.orange, fontWeight: FontWeight.w700, fontSize: 12));

  //Car Page

  static TextStyle carTitleText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 12));
  static TextStyle plateNameText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[500], fontWeight: FontWeight.w500, fontSize: 11));

  // Finish Page

  static TextStyle totalValuePaid = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w700, fontSize: 12));
  static TextStyle warrantyText = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[600], fontWeight: FontWeight.w400, fontSize: 12));

  //Dialog

  static TextStyle dialogTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w800, fontSize: 17));
  static TextStyle dialogMessage = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 14));
  static TextStyle dialogSubtitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 12));
  static TextStyle closeButton = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.red, fontWeight: FontWeight.w500, fontSize: 14));
  static TextStyle okButton = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.green, fontWeight: FontWeight.w500, fontSize: 14));

  //Receipt Page

  static TextStyle receiptTitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 12));
  static TextStyle receiptSubtitle = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 11));
  static TextStyle receiptMarker = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 11));
  static TextStyle receiptMessage = GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 11));
}
