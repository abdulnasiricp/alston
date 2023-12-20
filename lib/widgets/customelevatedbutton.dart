// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/appcolors.dart';
import 'package:get/get.dart';
import '../utils/theme_controller.dart';

class CustomElevatedButton extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor; // Existing property for button background color
  final Color? textColor; // New property for text color

   CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor, // Initialize the new property
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(

          color: themeController.isDarkMode.value
              ? AppColors.primaryColor
              : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black)
          
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
             
            primary: Colors.transparent, // Make the button transparent
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: textColor ?? AppColors.textColor,
            ).merge(GoogleFonts.josefinSans()),
          ),
        ),
      ),
    );
  }
}
