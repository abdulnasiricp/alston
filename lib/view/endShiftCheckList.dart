// ignore_for_file: depend_on_referenced_packages, unused_local_variable, unused_element, avoid_print, unnecessary_string_interpolations, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:alston/api/api_service.dart';
import 'package:alston/model/EndShift/endShiftstep1_model.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/view/location_model.dart';
import 'package:alston/widgets/endCheckList.dart';
import 'package:http/http.dart' as http;

import 'package:alston/utils/theme_controller.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:alston/widgets/customtextformfield.dart';
import 'package:alston/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndShiftCheckList extends StatefulWidget {
  final String? busNumber;
  final String? driverName;

  const EndShiftCheckList({Key? key, this.busNumber, this.driverName})
      : super(key: key);

  @override
  State<EndShiftCheckList> createState() => _EndShiftCheckListState();
}

class _EndShiftCheckListState extends State<EndShiftCheckList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _locationName = TextEditingController();

  final TextEditingController _mileage = TextEditingController();

  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  late String busNumber = '';
  late String driverName = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId');
    vehicleId = sp.getInt('vehicleId');
    apiToken = sp.getString('apiToken') ?? "";
    busNumber = sp.getString('BusNumber') ?? "";
    driverName = sp.getString('userName') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});

   await fetchVehiclePosition();
  }

   @override
  void initState() {
    super.initState();

    LoadData();
    
  }

late String long;
late String lat;
late String stringValue = long;
late double doubleValueLong = double.parse(stringValue);
late String stringValuelat = lat;
late double doubleValueLat = double.parse(stringValuelat);
  
Future<void> fetchVehiclePosition() async {
  const apiUrl = "https://service.takip724.com/?type=rest&token=17713E4D-F452-47D8-9879-54F336ED8292&serviceType=VehicleLastPosition&plate=BS03%20BU";

  // try {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the response JSON
      final responseData = json.decode(response.body);
      
      // Map the JSON to your model
      final vehiclePosition = LocationDetials.fromJson(responseData[0]);

      // Now you can use the data as needed
      print(vehiclePosition.longitude);
      print(vehiclePosition.latitude);
        // Update the state with the address
        setState(() {
          long = vehiclePosition.longitude;
          lat = vehiclePosition.latitude;
        });
    } else {
      // Handle errors
      print("Failed to fetch data. Status code: ${response.statusCode}");
    }
  // } catch (error) {
  //   // Handle exceptions
  //   print("Error: $error");
  // }
}



  final ApiService apiService = Get.put(ApiService());

  EndShiftEosStep1? response;

  void _myBookingState(
      int? vehicleId,
      int? driverId,
      String apiToken,
      String mileage,
      String location,
      double latitude,
      double longitude) async {
    response = await apiService.saveESOStep1(
        vehicleId, driverId, apiToken, mileage, location, latitude, longitude);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      Data bookingDetails = response!.data;

      print('------------>> EosId ${bookingDetails.eosId}');
      setState(() {});
      // Navigate to the next screen
      Get.to(() => EndCheckList(
        apiToken: apiToken,
        eosId: bookingDetails.eosId,

          ));
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  late Data? bookingDetails = response!.data;

  @override
  Widget build(BuildContext context) {
    print('--------$busNumber');
    print('--------$driverName');

    // Accessing the ThemeController
    final ThemeController themeController = Get.find<ThemeController>();

    // Using Obx to listen to changes
    return Obx(() {
      // Determine if dark mode is enabled
      final isDarkMode = themeController.isDarkMode.value;

      // Choose colors based on the theme mode
      final Color appBarColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;
      final Color backgroundColor = isDarkMode
          ? AppColors.backgroundColorDarker
          : AppColors.backgroundColor;
      final Color textColor =
          isDarkMode ? AppColors.textColorDarker : AppColors.textColor;
      final Color primaryColor =
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor;

      return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MyDrawerHeader(), // Make sure this is properly defined or remove if not needed
                myDrawerList(), // Make sure this is properly defined or remove if not needed
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pre-Start Checklist', style: GoogleFonts.lato()),
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
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 7),
                  CenterTextPair(
                    text: 'Driver Name : ',
                    value: '$driverName',
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.textColor,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CenterTextPair(
                    text: 'Bus Number : ',
                    value: '$busNumber',
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.textColor,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 2),
                  CustomTextFormField(
                    labelText: "Enter location name",
                    obscureText: false,
                    controller: _locationName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Location cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextFormField(
                    labelText: "Enter Mileage",
                    obscureText: false,
                    controller: _mileage,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mileage cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02 * 2.5),
                  CustomElevatedButton(
                    buttonText: 'Submit info',
                    buttonColor: themeController.isDarkMode.value
                        ? AppColors.primaryColorDarker
                        : AppColors.primaryColor,
                    textColor: themeController.isDarkMode.value
                        ? AppColors.whiteColor
                        : AppColors.whiteColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _myBookingState(
                            vehicleId,
                            driverId,
                            apiToken,
                            '${_mileage.text}',
                            '${_locationName.text}',
                            doubleValueLong,
                            doubleValueLat);
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

// Helper widget to create a row of text with a title and value
class CenterTextPair extends StatelessWidget {
  final String text;
  final String value;
  final Color textColor;

  const CenterTextPair({
    Key? key,
    required this.text,
    required this.value,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w100,
          ).merge(GoogleFonts.josefinSans()),
        ),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
      ],
    );
  }
}
