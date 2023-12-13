// ignore_for_file: depend_on_referenced_packages, file_names, unused_element, unused_local_variable, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/customtextformfield.dart';
import 'package:alston/view/confirmbusscreen.dart';

import '../api/api_service.dart';

import '../model/Login/login_response_model.dart';
import '../utils/theme_controller.dart';
class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userId = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final ApiService apiService = Get.put(ApiService());

  LoginResponse? response;


  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await apiService.isUserLoggedIn();
    if (isLoggedIn) {
     

      List<String> busNumbers = response!.data.assignedRoutes
          .map((route) => route.busNumber)
          .toList();
      print(busNumbers.toString());
    String driverName = response!.data.userName;
      print(driverName.toString());

      Get.offAll(()=>ConfirmBusScreen(busNumbers: busNumbers,driverName: driverName,));
    }
  }

  void _attemptLogin(String email, String password) async {
    response = await apiService.login(email, password);
    print(response);
    if (response != null && response?.success == 1) {
      // Extract bus numbers from the response

      List<String> busNumbers = response!.data.assignedRoutes
          .map((route) => route.busNumber)
          .toList();
      debugPrint("BUS NUMBER");
      print(busNumbers.toString());
      debugPrint(busNumbers.length.toString());
      String driverName = response!.data.userName;
      print(driverName.toString());
       String busNumber1 = response!.data.busNumber;
      print(busNumber1.toString());

List<String> combinedBusNumbers = [...busNumbers, busNumber1];
String ApiToken = response!.data.apiToken;
      print(ApiToken.toString());

      int driverID = response!.data.driverId;
      print(driverID.toString());
    

      // Pass the bus numbers to ConfirmBusScreen
      Get.offAll(ConfirmBusScreen(busNumbers: combinedBusNumbers,driverName: driverName,apiToken: ApiToken,driverId:driverID ,));
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Login failed. Please check your credentials.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      // Colors are chosen based on the theme status
      Color backgroundColor = themeController.isDarkMode.value
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      Color primaryColor = themeController.isDarkMode.value
          ? AppColors.primaryColor
          : AppColors.primaryColorDark;
      Color textColor = themeController.isDarkMode.value
          ? AppColors.textColor
          : AppColors.textColorDarker;

      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double verticalPadding = screenHeight * 0.02;
      double headingFontSize = screenWidth * 0.1;
      double subheadingFontSize = screenWidth * 0.04;

      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          height: screenHeight,
          width: screenWidth,
          color: backgroundColor,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.14),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.lato(
                      fontSize: headingFontSize,
                      color: themeController.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors.backgroundColorDarker,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.12),
                  Text(
                    'Please Sign In to start your shift',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.josefinSans(
                      color: themeController.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors.backgroundColorDarker,
                      fontSize: subheadingFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                  CustomTextFormField(
                    labelText: "Enter User-Id",
                    controller: _userId,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "User-Id cannot be empty";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: verticalPadding),
                  CustomTextFormField(
                    labelText: "Enter Password",
                    controller: _password,
                    obscureText: true, // Hide password input
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomElevatedButton(
                    buttonText: 'Sign In',
                    buttonColor: themeController.isDarkMode.value
                        ? AppColors.primaryColorDarker
                        : AppColors.primaryColor,
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.whiteColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _attemptLogin(_userId.text, _password.text);
                      }
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
