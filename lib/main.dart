// ignore_for_file: depend_on_referenced_packages

import 'package:alston/utils/theme_controller.dart';
import 'package:alston/view/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize your ThemeController
    final ThemeController themeController = Get.put(ThemeController());

    // Using Obx here to listen for changes in the theme
    return Obx(() => GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(), // Define your light theme here
          darkTheme: ThemeData.dark(), // Define your dark theme here
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light, // Bind the themeMode to isDarkMode
          home: const StartScreen(),
        ));
  }
}
