// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:alston/utils/appcolors.dart';
import 'package:alston/utils/theme_controller.dart';
import 'package:alston/view/prestartchecklist.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowEndTask extends StatefulWidget {
  const ShowEndTask({super.key});

  @override
  State<ShowEndTask> createState() => _ShowEndTaskState();
}

class _ShowEndTaskState extends State<ShowEndTask> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      // Determine if dark mode is enabled

      // Choose colors based on the theme mode

      return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MyDrawerHeader(), // Make sure this is properly defined or remove if not needed
                myDrawerList(),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please complete the Pre-Start activity ',
                      style: TextStyle(
                        color: Colors.green, // Change color as needed
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const PreStartCheckList());
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.whiteColor)),
                        child: const Text('Pre-Start CheckList'),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
