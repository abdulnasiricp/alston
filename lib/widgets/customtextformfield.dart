// ignore_for_file: depend_on_referenced_packages

import 'package:alston/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final ThemeController themeController = Get.find<ThemeController>();
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    required this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final double fontSize = screenHeight * 0.02;

    return SizedBox(
      height: 60.0, // Set your desired height
      child: TextFormField(
        cursorColor: AppColors.primaryColorDark,
        keyboardType: TextInputType.emailAddress,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0, // Adjust the vertical padding
            horizontal: 20.0, // Adjust the horizontal padding
          ),
          filled: true,
          hintMaxLines: 1,
          labelText: labelText,
          hintStyle: const TextStyle(
            fontSize: 12.0, // Set your desired font size for the placeholder
            color: Colors.grey, // Set your desired color for the placeholder
          ),
          errorStyle: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 12,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeController.isDarkMode.value
                  ? AppColors.backgroundColor
                  : AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeController.isDarkMode.value
                  ? AppColors.backgroundColor
                  : AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeController.isDarkMode.value
                  ? AppColors.backgroundColor
                  : AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          labelStyle: GoogleFonts.josefinSans(
            textStyle: TextStyle(
              color: themeController.isDarkMode.value
                  ? AppColors.backgroundColor
                  : AppColors.primaryColor,
              fontSize: fontSize,
            ),
          ),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
