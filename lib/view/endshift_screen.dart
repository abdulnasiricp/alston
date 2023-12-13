// ignore_for_file: depend_on_referenced_packages

import 'package:alston/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appcolors.dart';
import '../widgets/navigationdrawer.dart';
import '../utils/theme_controller.dart'; // Import your theme controller
import 'package:google_fonts/google_fonts.dart';
class EndShiftScreen extends StatelessWidget {
  const EndShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyDrawerHeader(),
              myDrawerList(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:Text(
          'ALSTON Link',
          style: GoogleFonts.lato(),
        ),
        backgroundColor: themeController.isDarkMode.value
            ? AppColors.primaryColor
            : AppColors.backgroundColors,
      ),

      body: Obx(() => Container(
        color: themeController.isDarkMode.value
            ? AppColors.backgroundColorDarker
            : AppColors.backgroundColor,
        // Use Obx to listen for changes
        child: Center( // Add Center widget to center the Card
          child: Card(
            color: themeController.isDarkMode.value
                ? AppColors.primaryColor
                : AppColors.backgroundColors, // Light mode color
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Check Bus !',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkMode.value
                          ? AppColors.whiteColor // Dark mode text color
                          : AppColors.whiteColor, // Light mode text color
                    ).merge(GoogleFonts.josefinSans()),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Do you want to end your shift on this bus today?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5, // Set your desired line height
                      color: themeController.isDarkMode.value
                          ? AppColors.whiteColor // Dark mode text color
                          : AppColors.whiteColor, // Light mode text color
                    ).merge(GoogleFonts.josefinSans()),
                  ),

                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0), // Set your desired margin bottom
                    child: ElevatedButton(
                      onPressed: () {
                        // Yes button action
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: themeController.isDarkMode.value
                            ? AppColors.backgroundColors // Dark mode button color
                            : AppColors.primaryColor, // Light mode button color
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text(
                        'YES',
                        style: GoogleFonts.josefinSans(),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.to(const HomePage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: themeController.isDarkMode.value
                          ? AppColors.primaryColorDarker // Dark mode text color
                          : Colors.blueAccent, // Light mode text color
                      textStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),

                    child: Text(
                      'No!-Skip !',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: themeController.isDarkMode.value
                            ? AppColors.whiteColor // Dark mode text color
                            : AppColors.whiteColor,
                        // Light mode text color
                      ).merge(GoogleFonts.josefinSans()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),

    );
  }
}
