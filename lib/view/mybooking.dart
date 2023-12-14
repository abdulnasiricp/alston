// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unused_element, avoid_print, unnecessary_string_interpolations

import 'package:alston/api/api_service.dart';
import 'package:alston/model/my-Booking/acknowledge-booking_model.dart';
import 'package:alston/model/my-Booking/my_booking_model.dart';
import 'package:alston/model/my-Booking/viewBooking_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_controller.dart';
import '../utils/appcolors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navigationdrawer.dart';

class MyBooking extends StatefulWidget {
 

  const MyBooking({Key? key, }) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {

  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId');
    vehicleId = sp.getInt('vehicleId');
    apiToken = sp.getString('apiToken') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});
  }


getData()async{
  await  LoadData();
  await  _myBookingState(
      apiToken,
      driverId,
      'td');
}

   @override
  void initState() {
    super.initState();

    getData();
    
  }
  final ApiService apiService = Get.put(ApiService());

  MyBookingDetails? response;

  Future<void> _myBookingState(String apiToken, int? driverId, String day) async {
    response = await apiService.myBookingsDetails(apiToken, driverId, day);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      List<Datum> bookingDetails = response!.data;

      for (final bookingDetail in bookingDetails) {
        print(bookingDetail.bookingId);
        print(bookingDetail.bookingNumber);
      }
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  AcknowledgeBooking? acknowledgeResponse;

  void _acknowledgeMessage(
      String? apiToken, int? driverId, int? bookingId) async {
    acknowledgeResponse =
        await apiService.acknowledgeDetails(apiToken, driverId, bookingId);
    print('---------response $acknowledgeResponse');
    if (response != null) {
      AcknowledgeBooking? bookingDetails = acknowledgeResponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP);
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  ViewBooking? viewBookingResponse;

  void viewBooking(String? apiToken, int? bookingId) async {
    viewBookingResponse =
        await apiService.viewBookingDetails(apiToken, bookingId);
    print('---------response $viewBookingResponse');
    if (response != null && response?.success == 1) {
      List<DataDetails> viewBookingDetials = viewBookingResponse!.data;

      for (final viewBookingDetials in viewBookingDetials) {
       
        Get.defaultDialog(
            title: 'View Booking Details',
            content: Column(
              children: [
                Text("${viewBookingDetials.destination}"),
                Text("${viewBookingDetials.bookingId}"),
                Text("${viewBookingDetials.comments}"),
                Text("${viewBookingDetials.customer}"),
                Text("${viewBookingDetials.dateTime}"),
                Text("${viewBookingDetials.driverStatus}"),
                Text("${viewBookingDetials.mobileNo}"),
                Text("${viewBookingDetials.noteToDriver}"),
                Text("${viewBookingDetials.pax}"),
                Text("${viewBookingDetials.paxName}"),
                Text("${viewBookingDetials.bookingNumber}"),
                Text("${viewBookingDetials.personIncharge}"),
                Text("${viewBookingDetials.pickupLocation}"),
                Text("${viewBookingDetials.reason}"),
                Text("${viewBookingDetials.tripStatus}"),
              ],
            ));
      }

      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

 

  @override
  Widget build(BuildContext context) {
  

    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
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
          centerTitle: true,
          title: Text('My Booking', style: GoogleFonts.lato()),
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
        body: _buildBody(), // Add this line to include the body
      );
    });
  }

  Widget _buildBody() {
    if (response != null && response!.success == 1) {
      List<Datum> bookingDetails = response!.data;

      return ListView.builder(
        itemCount: bookingDetails.length,
        itemBuilder: (context, index) {
          Datum bookingDetail = bookingDetails[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: InkWell(
              onTap: () {
                viewBooking(apiToken, bookingDetail.bookingId);
              },
              child: Card(
                color: Colors.deepPurple[50],
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
                            Text('Vehicle:'),
                            Text('Date/Time:'),
                            Text('PickUp Location:'),
                            Text('Pax:'),
                            Text('Reason:'),
                            Text('Destination:'),
                            Text('Booking:'),
                            Text('Status:'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${bookingDetail.vehicleNumber}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.dateTime}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.pickupLocation}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.pax}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.reason}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.destination}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.bookingNumber}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${bookingDetail.tripStatus}',
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    backgroundColor: Colors.deepPurple[50],
                                    title: '',
                                    content: const Text(
                                      'Are you acknowlage the Driver',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    textConfirm: 'Acknowlodge',
                                    textCancel: 'Cencel',
                                    onConfirm: () {
                                      _acknowledgeMessage(
                                          apiToken,
                                          driverId,
                                          bookingDetail.bookingId);
                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      Navigator.pop(context);
                                    });
                              },
                              icon: const Icon(Icons.settings))
                        ],
                      )
                    ],
                  ),
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
