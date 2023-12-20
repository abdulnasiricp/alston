// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'package:alston/model/config_model.dart';
import 'package:alston/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    ConfigModel appConfig = ConfigModel(baseUrl: "", password: "");

    final TextEditingController urlController =
        TextEditingController(text: appConfig.baseUrl);
    final TextEditingController passwordController =
        TextEditingController(text: appConfig.password);

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            color: backgroundColor, // Dynamic background color
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              backgroundColor: AppColors.backgroundColorsDarker,
                              title: 'Config',
                              titleStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              contentPadding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        controller: urlController,
                                        isRead: false,
                                        labelText: 'Url',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter URl";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        controller: passwordController,
                                        isRead: false,
                                        labelText: 'Password',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Password";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Update the configuration values
                                            appConfig.baseUrl =
                                                urlController.text;
                                            appConfig.password =
                                                passwordController.text;
                                          }
                                        },
                                        child: const Text(
                                          'Submit Url',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Reset to Pre-Config',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                          ))),
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
                  // TypeWriterText(
                  //   text: Text(
                  //     'ALSTON\nLink',
                  //     textAlign: TextAlign.center,
                  //     style: GoogleFonts.acme(
                  //         fontSize: titleFontSize,
                  //         color: textColor), // Dynamic text color
                  //   ),
                  // duration: const Duration(milliseconds: 100),
                  // ),
                  Text(
                    'ALSTON\nLink',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.acme(
                        fontSize: titleFontSize, color: textColor),
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
        ),
      );
    });
  }
}
