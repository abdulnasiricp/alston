// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:alston/utils/appcolors.dart';
import 'package:alston/utils/theme_controller.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCompleteTask extends StatefulWidget {
  const ShowCompleteTask({super.key});

  @override
  State<ShowCompleteTask> createState() => _ShowCompleteTaskState();
}

class _ShowCompleteTaskState extends State<ShowCompleteTask> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyDrawerHeader(), // Make sure this is properly defined or remove if not needed
              myDrawerList(), // Make sure this is properly defined or remove if not needed
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeController.isDarkMode.value
            ? AppColors.primaryColor
            : AppColors.backgroundColors,
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode // Icon for light mode
                  : Icons.dark_mode, // Icon for dark mode
              color: themeController.isDarkMode.value
                  ? AppColors.darkModeIcon
                  : AppColors.primaryColor, // Icon color in light mode
            ),
            onPressed: () {
              // Toggle the theme
              themeController.toggleTheme(!themeController.isDarkMode.value);
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColorBlue,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Pre-Start Checklist\n Completed Today',
                  style: TextStyle(
                    color: Colors.green, // Change color as needed
                    fontSize: 20,
                  ),
                ),
                Card(
                    color: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
