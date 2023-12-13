// ignore_for_file: depend_on_referenced_packages

import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/sign_in_screen.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme_controller.dart'; // Import the ThemeController

class NotConfirmBusScreen extends StatelessWidget {
  const NotConfirmBusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController =
        Get.find<ThemeController>(); // Find the ThemeController

    // Use MediaQuery to obtain screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive padding and spacing
    final sidePadding = screenWidth * 0.1;
    final verticalSpacingLarge = screenHeight * 0.05;
    final verticalSpacingSmall = screenHeight * 0.02;

    // Responsive font size
    final fontSize = screenWidth * 0.04;

    // Responsive image size
    final imageSize = screenWidth * 0.3;

    return Scaffold(
      body: Obx(() => Container(
            // Use Obx to listen to changes in the theme
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            color: themeController.isDarkMode.value
                ? AppColors.backgroundColorDarker // Dark theme background color
                : AppColors.backgroundColor, // Light theme background color
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: imageSize,
                  width: imageSize,
                  image: const AssetImage('assets/images/warning.png'),
                ),
                SizedBox(height: verticalSpacingLarge),
                Text(
                  'Call The Dispatcher and Inform You are in the Wrong bus, Ask to Verify',
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? AppColors.backgroundColor // Dark theme text color
                        : AppColors.primaryColor, // Light theme text color
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: verticalSpacingSmall),
                CustomElevatedButton(
                  buttonText: 'Ok',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.whiteColor,
                  onPressed: () {
                    Get.to(() =>
                        const SignInScreen()); // Make sure to construct a new SignInScreen
                  },
                ),
              ],
            ),
          )),
    );
  }
}
