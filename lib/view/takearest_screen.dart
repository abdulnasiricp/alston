// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, unused_local_variable, avoid_unnecessary_containers

import 'dart:async';
import 'package:alston/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appcolors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme_controller.dart';
import '../widgets/customelevatedbutton.dart';
import '../widgets/customtextformfield.dart';
import '../widgets/navigationdrawer.dart';

class TakeARestScreen extends StatefulWidget {
  const TakeARestScreen({Key? key}) : super(key: key);

  @override
  _TakeARestScreenState createState() => _TakeARestScreenState();
}

class _TakeARestScreenState extends State<TakeARestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationName = TextEditingController();
  final TextEditingController _odometer = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();
  late String _buttonText = 'Start Resting';
  late bool _isRunning = false;
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      setState(() {
        _buttonText = 'Resume';
        _isRunning = false;
        _timer?.cancel();
      });
    } else {
      setState(() {
        _buttonText = 'Stop Resting';
        _isRunning = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
          setState(() {
            _elapsedSeconds++;
          });
        });
      });
    }
  }

  String _formatTime(int totalSeconds) {
    final int seconds = totalSeconds % 60;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int hours = totalSeconds ~/ (60 * 60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void resetAndGoHome() {
    setState(() {
      _elapsedSeconds = 0; // Reset stopwatch counter to zero
      _isRunning = false; // Stop the stopwatch if it's running
    });
    _timer?.cancel(); // Cancel the timer
    Get.to(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive layout
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              const MyDrawerHeader(),
              myDrawerList(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('TAKE A REST', style: GoogleFonts.lato()),
        centerTitle: true,
        backgroundColor: themeController.isDarkMode.value
            ? AppColors.primaryColor
            : AppColors.backgroundColors,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.sync),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
          color: themeController.isDarkMode.value
              ? AppColors.backgroundColorDarker
              : AppColors.backgroundColor,
          child: Form(
            key: _formKey,
            child: Obx(() {
              // Retrieve the ThemeController
              final ThemeController themeController =
                  Get.find<ThemeController>();

              // Colors are chosen based on the theme status
              Color textColor = themeController.isDarkMode.value
                  ? AppColors.textColor
                  : AppColors.textColorDarker;

              return Column(
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.size.height * 0.1,
                  ),
                  Text(
                    'You Are Operating Bus BS04HW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.size.width * 0.05,
                      color: themeController.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors
                              .backgroundColorDarker, // Set the dynamic color
                    ).merge(GoogleFonts.josefinSans()),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.05),
                  CustomTextFormField(
                    labelText: 'Enter Odometer Reading, Km',
                    obscureText: false,
                    controller: _odometer,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Odometer reading cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.02),
                  CustomTextFormField(
                    labelText: 'Enter Resting Location',
                    obscureText: false,
                    controller: _locationName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Location cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.05),
                  Text(
                    _formatTime(_elapsedSeconds),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.size.width *
                          0.1, // Assuming you have a digital font
                    ).merge(GoogleFonts.josefinSans()),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.05),
                  CustomElevatedButton(
                    buttonText: _buttonText,
                    buttonColor: themeController.isDarkMode.value
                        ? AppColors.primaryColorDark
                        : AppColors.primaryColor,
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.whiteColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _toggleTimer();
                      }
                    },
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.05),
                  CustomElevatedButton(
                    buttonColor: themeController.isDarkMode.value
                        ? Colors.grey
                        : Colors.grey,
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.whiteColor,
                    buttonText: 'Cancel',
                    onPressed: () {
                      resetAndGoHome();
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
