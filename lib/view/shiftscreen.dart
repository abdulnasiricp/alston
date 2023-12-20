// ignore_for_file: depend_on_referenced_packages, unused_local_variable, avoid_print, non_constant_identifier_names, unnecessary_string_interpolations
import 'package:alston/api/api_service.dart';
import 'package:alston/model/my-Booking/completed_booking_model.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/theme_controller.dart';
import '../widgets/navigationdrawer.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
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
          body: const TabBarView(
            children: <Widget>[
              TodayShift(),
              WeekShift(),
              MonthShift(),
            ],
          ),
        ),
      );
    });
  }
}

class TodayShift extends StatefulWidget {
  const TodayShift({super.key});

  @override
  State<TodayShift> createState() => _TodayShiftState();
}

class _TodayShiftState extends State<TodayShift> {
  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId') ?? 1;
    vehicleId = sp.getInt('vehicleId') ?? 1;
    apiToken = sp.getString('apiToken') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});
  }

  getData() async {
    await LoadData();
    await _myBookingState(apiToken, driverId, 'td');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final ApiService apiService = Get.put(ApiService());

  ShiftDetails? response;

  Future<void> _myBookingState(
      String apiToken, int? driverId, String day) async {
    response = await apiService.shiftCompletedDetails(apiToken, driverId, day);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      List<CompletedData> bookingDetails = response!.data;

      for (final bookingDetail in bookingDetails) {
        print(bookingDetail.bookingId);
        print(bookingDetail.bookingNumber);
      }
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (response != null && response!.success == 1) {
      List<CompletedData> bookingDetails = response!.data;
      final ThemeController themeController = Get.find<ThemeController>();

      return bookingDetails.isEmpty
          ? const Center(
              child: Text('No reports available'),
            )
          : ListView.builder(
              itemCount: bookingDetails.length,
              itemBuilder: (context, index) {
                CompletedData bookingDetail = bookingDetails[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    // color: AppColors.primaryColor,
                    color: themeController.isDarkMode.value
                    ? AppColors.backgroundColors
                    : AppColors.primaryColor, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time:',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text('Pax:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('PickUp Location:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Date/Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('hours:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Destination:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Customer:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('End Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Vehicle #:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 1.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text('${bookingDetail.startTime}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),

                                Text(
                                  '${bookingDetail.pax}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),

                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.pickupLocation}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.dateTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  '${bookingDetail.hours}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.destination}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.customer}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.endTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.vehicleNumber}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    } else {
      // Return a message or widget if there is no data or if there was an error
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class WeekShift extends StatefulWidget {
  const WeekShift({super.key});

  @override
  State<WeekShift> createState() => _WeekShiftState();
}

class _WeekShiftState extends State<WeekShift> {
  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId') ?? 1;
    vehicleId = sp.getInt('vehicleId') ?? 1;
    apiToken = sp.getString('apiToken') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});
  }

  getData() async {
    await LoadData();
    await _myBookingState(apiToken, driverId, 'tw');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final ApiService apiService = Get.put(ApiService());

  ShiftDetails? response;

  Future<void> _myBookingState(
      String apiToken, int? driverId, String day) async {
    response = await apiService.shiftCompletedDetails(apiToken, driverId, day);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      List<CompletedData> bookingDetails = response!.data;

      for (final bookingDetail in bookingDetails) {
        print(bookingDetail.bookingId);
        print(bookingDetail.bookingNumber);
      }
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
      final ThemeController themeController = Get.find<ThemeController>();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (response != null && response!.success == 1) {
      List<CompletedData> bookingDetails = response!.data;

      return bookingDetails.isEmpty
          ? const Center(
              child: Text('No reports available'),
            )
          : ListView.builder(
              itemCount: bookingDetails.length,
              itemBuilder: (context, index) {
                CompletedData bookingDetail = bookingDetails[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    // color: AppColors.primaryColor,
                    color: themeController.isDarkMode.value
                    ? AppColors.backgroundColors
                    : AppColors.primaryColor, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time:',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text('Pax:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('PickUp Location:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Date/Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('hours:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Destination:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Customer:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('End Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Vehicle #:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 1.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text('${bookingDetail.startTime}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
          
                                Text(
                                  '${bookingDetail.pax}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
          
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.pickupLocation}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.dateTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  '${bookingDetail.hours}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.destination}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.customer}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.endTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.vehicleNumber}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    } else {
      // Return a message or widget if there is no data or if there was an error
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class MonthShift extends StatefulWidget {
  const MonthShift({super.key});

  @override
  State<MonthShift> createState() => _MonthShiftState();
}

class _MonthShiftState extends State<MonthShift> {
  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId') ?? 1;
    vehicleId = sp.getInt('vehicleId') ?? 1;
    apiToken = sp.getString('apiToken') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});
  }

  getData() async {
    await LoadData();
    await _myBookingState(apiToken, driverId, "tm");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final ApiService apiService = Get.put(ApiService());

  ShiftDetails? response;

  Future<void> _myBookingState(
      String apiToken, int? driverId, String day) async {
    response = await apiService.shiftCompletedDetails(apiToken, driverId, day);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      List<CompletedData> bookingDetails = response!.data;

      for (final bookingDetail in bookingDetails) {
        print(bookingDetail.bookingId);
        print(bookingDetail.bookingNumber);
      }
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (response != null && response!.success == 1) {
      List<CompletedData> bookingDetails = response!.data;
      final ThemeController themeController = Get.find<ThemeController>();

      return bookingDetails.isEmpty
          ? const Center(
              child: Text('No reports available'),
            )
          : ListView.builder(
              itemCount: bookingDetails.length,
              itemBuilder: (context, index) {
                CompletedData bookingDetail = bookingDetails[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    // color: AppColors.primaryColor,
                    color: themeController.isDarkMode.value
                    ? AppColors.backgroundColors
                    : AppColors.primaryColor, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time:',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text('Pax:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('PickUp Location:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Date/Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('hours:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Destination:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Customer:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('End Time:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text('Vehicle #:',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 1.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text('${bookingDetail.startTime}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),

                                Text(
                                  '${bookingDetail.pax}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),

                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.pickupLocation}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.dateTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  '${bookingDetail.hours}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.destination}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.customer}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.endTime}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  width: screenWidth * 0.430,
                                  child: Text(
                                    '${bookingDetail.vehicleNumber}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    } else {
      // Return a message or widget if there is no data or if there was an error
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
