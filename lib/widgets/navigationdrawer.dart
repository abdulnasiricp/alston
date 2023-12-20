// ignore_for_file: depend_on_referenced_packages
import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/mybooking.dart';
import 'package:alston/view/notification.dart';
import 'package:alston/view/prestartchecklist.dart';
import 'package:alston/view/shiftscreen.dart';
import 'package:alston/view/sign_in_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme_controller.dart';
import '../view/endshift_screen.dart';
import '../view/homepage.dart';
import '../view/takearest_screen.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() => Container(
        width: double.infinity,
        height: 245,
        color: themeController.isDarkMode.value
            ? AppColors.primaryColor
            : AppColors.backgroundColors,
        padding: const EdgeInsets.only(left: 15, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const CircleAvatar(
                maxRadius: 50,
                backgroundImage: AssetImage('assets/images/user.png')),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Imax Melbourne',
              style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors.secondaryColor,
                      fontSize: 20)
                  .merge(GoogleFonts.lato()),
            ),
          ],
        )));
  }
}

Widget myDrawerList() {
  return Column(
    children: [
      manuItem(
        'Home',
        Icons.home,
        () => Get.offAll(const HomePage()),
      ),
      manuItem(
        'Notification',
        Icons.notifications_none_rounded,
        () => Get.to(()=>const ChatScreen()),
      ),
        manuItem('Pre-Start', Icons.folder_copy,
          () => Get.to(()=>const PreStartCheckList())),
      manuItem('Shifts', Icons.folder_copy_outlined,
          () => Get.to(()=>const ShiftScreen())),
        
      manuItem('My Bookings', Icons.timer_outlined,
          () => Get.to(()=>const MyBooking())),
      const Divider(thickness: 1, height: 1),
      manuItem('Take A Rest', Icons.timer_outlined,
          () => Get.to(()=>const TakeARestScreen())),
      manuItem('Bus Routes', Icons.map_outlined,
          () => Get.to(()=>const MyBooking())),
      manuItem(
          'End Shift', Icons.lock, () => Get.to(()=>const EndShiftScreen())),
      const Divider(thickness: 1, height: 1),
      manuItem('Logout ', Icons.logout, () => Get.offAll(const SignInScreen())),
    ],
  );
}

Widget manuItem(String title, IconData? icon, Function()? onPressed) {
  final ThemeController themeController = Get.find<ThemeController>();
  Color getTextColor(bool isDarkMode) {
    return isDarkMode ? AppColors.backgroundColor : AppColors.secondaryColor;
  }

  return Material(
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                icon,
                color: themeController.isDarkMode.value
                    ? AppColors.backgroundColor
                    : AppColors.secondaryColor,
                size: 28,
              ),
            )),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: getTextColor(themeController.isDarkMode.value),
                ).merge(GoogleFonts.josefinSans()),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
