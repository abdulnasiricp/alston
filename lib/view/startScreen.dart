// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/sign_in_screen.dart';
import 'package:alston/widgets/customelevatedbutton.dart';

import '../utils/theme_controller.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      // Decide the colors based on the theme
      Color backgroundColor = themeController.isDarkMode.value
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      Color textColor = themeController.isDarkMode.value
          ? AppColors.textColorDarker
          : AppColors.textColor;

      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double sidePadding = screenWidth * 0.1;
      double topPadding = screenHeight * 0.15;
      double logoHeight = screenHeight * 0.3;
      double spaceAfterLogo = screenHeight * 0.05;
      double spaceBeforeButton = screenHeight * 0.1;
      double titleFontSize = screenWidth * 0.08;

      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          color: backgroundColor, // Dynamic background color
          child: Center(
            child: Column(
              children: [
                SizedBox(height: topPadding),
                SizedBox(
                  height: logoHeight,
                  width: screenWidth,
                  child: Animate(
                    effects: const [
                      ScaleEffect(duration: Duration(seconds: 1)),
                      SlideEffect(),
                    ],
                    child: const Image(
                        image: AssetImage('assets/images/AlstonLogo.png')),
                  ),
                ),
                SizedBox(height: spaceAfterLogo),
                TypeWriterText(
                  text: Text(
                    'ALSTON\nLink',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.acme(
                        fontSize: titleFontSize,
                        color: textColor), // Dynamic text color
                  ),
                  duration: const Duration(milliseconds: 100),
                ),
                SizedBox(height: spaceBeforeButton),
                CustomElevatedButton(
                  buttonText: 'Start',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: themeController.isDarkMode.value
                      ? AppColors.whiteColor
                      : AppColors.whiteColor,
                  onPressed: () {
                    Get.offAll(() => const SignInScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
