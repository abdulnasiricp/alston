// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  // Observable for the theme mode
  RxBool isDarkMode = false.obs;

  // Method to toggle the theme
  void toggleTheme(bool isOn) {
    isDarkMode.value = isOn;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Here you would also save the preference to persistent storage
  }
}
