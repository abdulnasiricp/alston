
import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primaryColor = Color(0xE032607A);
  static const Color secondaryColor = Color(0xFF020024);
  static const Color textColor = Color(0xFF333333);
  static const Color backgroundColor = Color(0xFFF7F8F9);
  static const Color backgroundColors = Color(0xFF8DB2CF);
  static const Color whiteColor = Color(0xFFF1F2F4);
  static const Color messageColor = Color(0xFFfdbb2d);
  static LinearGradient buttonBackgroundLight = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 0.35, 1.0],
    colors: [
      Color.fromRGBO(2, 0, 36, 0.8784313725490196),
      Color.fromRGBO(17, 53, 77, 0.8784313725490196),
      Color.fromRGBO(50, 96, 122, 0.8784313725490196),
    ],
  );
  static LinearGradient buttonBackgroundDark = const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft, // Adjusted the stop value for the middle color
    colors: [
      Color(0xFFD3F0FE),
      Color(0xFF6FC8F0),
      Color(0xFF32607A),
    ],
  );
  static const Color darkModeIcon = Color(0xFFfdbb2d);
  static const Color primaryColorLight = Color(0xFF2C3E5D);
  static const Color primaryColorDark = Color(0xFF172B4D);

  // Darker versionsa
  static const Color primaryColorDarker =
      Color(0xFF1B1F23); // Darker shade of primaryColor
  static const Color secondaryColorDarker =
      Color(0xFF2C3E5D); // Darker shade of secondaryColor
  static const Color textColorDarker =
      Color(0xFF1B1F23); // Darker shade of textColor
  static const Color backgroundColorDarker =
      Color(0xFF1B1F23); // Darker shade of backgroundColor
  static const Color backgroundColorsDarker =
      Color(0xFF172B4D); // Darker shade of backgroundColors
}
