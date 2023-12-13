// ignore_for_file: depend_on_referenced_packages, unused_local_variable
import 'package:alston/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme_controller.dart';
import '../widgets/navigationdrawer.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the instance of ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    // Using Obx to listen to changes in the theme
    return Obx(() {
      // Access the theme values based on isDarkMode
      final isDarkMode = themeController.isDarkMode.value;
      final Color primaryColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;
      final Color backgroundColor = isDarkMode
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      final Color textColor =
          isDarkMode ? AppColors.textColorDarker : AppColors.textColor;

      return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MyDrawerHeader(), // Define this header or remove if not needed
                  myDrawerList(), // Define this method or remove if not needed
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'SHIFT REPORT',
              style: GoogleFonts.lato(),
            ),
            bottom: TabBar(
              unselectedLabelColor: AppColors.whiteColor,
              indicatorColor: themeController.isDarkMode.value
                  ? AppColors.backgroundColors
                  : AppColors.primaryColor,
              tabs: <Widget>[
                DefaultTextStyle(
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      // Customize the font style here
                      fontSize: 16.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      // Other text style properties...
                    ),
                  ),
                  child: const Tab(
                    icon: Icon(Icons.today),
                    text: 'Today',
                  ),
                ),
                DefaultTextStyle(
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      // Customize the font style here
                      fontSize: 16.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      // Other text style properties...
                    ),
                  ),
                  child: const Tab(
                    icon: Icon(Icons.today),
                    text: 'This Week',
                  ),
                ),
                DefaultTextStyle(
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      // Customize the font style here
                      fontSize: 16.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      // Other text style properties...
                    ),
                  ),
                  child: const Tab(
                    icon: Icon(Icons.today),
                    text: 'This Month',
                  ),
                ),
              ],
            ),
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
                  themeController
                      .toggleTheme(!themeController.isDarkMode.value);
                },
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              buildTabContext('Today You don\'t have any\nreport',
                  backgroundColor, textColor, themeController),
              buildTabContext('This Week You don\'t have\nany report',
                  backgroundColor, textColor, themeController),
              buildTabContext('This Month You don\'t have\nany report',
                  backgroundColor, textColor, themeController),
            ],
          ),
        ),
      );
    });
  }

  Widget buildTabContext(String text, Color backgroundColor, Color textColor,
      ThemeController themeController) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        child: Text(
          text,
          style: TextStyle(
            color: themeController.isDarkMode.value
                ? AppColors.whiteColor
                : AppColors.textColor,
            fontSize: 18, // Adjust the font size as needed
          ).merge(GoogleFonts.josefinSans()),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
