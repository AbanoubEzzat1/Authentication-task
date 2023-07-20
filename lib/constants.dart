import 'package:flutter/material.dart';

const textWhite = Color(0xFFFFFFFF);
const lightGreyButtons = Color(0xFFE9E9E8);
const darkGreen = Color(0xFF395A64);
const textBlack = Color(0xFF000000);
const darkBlue = Color(0xFF061C57);
const lightGreyReceiptBG = Color(0xFFACB4CC);
const red = Color(0xFFdc143c);
const green = Color(0xFF66cc66);

const mainButtonsSize = 60.0;

const mainFontSize = 25.0;
const FontWeight mainFontWeight = FontWeight.bold;

const subFontSize = 21.0;
const FontWeight subFontWeight = FontWeight.bold;

const commonTextSize = 18.0;
const FontWeight commonTextWeight = FontWeight.w700;

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum SnackBarType { success, error, loading }

void displaySnackBar(BuildContext context, String text, SnackBarType type) {
  Color backgroundColor;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = green;
      break;
    case SnackBarType.error:
      backgroundColor = red;
      break;
    case SnackBarType.loading:
      backgroundColor = darkBlue;
      break;
    default:
      backgroundColor = darkGreen;
  }

  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: backgroundColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
