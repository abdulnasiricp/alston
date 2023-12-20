// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unused_element, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:alston/api/api_service.dart';
import 'package:alston/model/dropofBooking.dart';
import 'package:alston/model/my-Booking/acknowledge-booking_model.dart';
import 'package:alston/model/my-Booking/my_booking_model.dart';
import 'package:alston/model/my-Booking/viewBooking_model.dart';
import 'package:alston/model/onTheWayBooking_model.dart';
import 'package:alston/model/pickupBooking_model.dart';
import 'package:alston/model/waitingBooking_model.dart';
import 'package:alston/view/ViewBookingDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_controller.dart';
import '../utils/appcolors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navigationdrawer.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({
    Key? key,
  }) : super(key: key);

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

  MyBookingDetails? response;

  Future<void> _myBookingState(
      String? apiToken, int? driverId, String? day) async {
    response = await apiService.myBookingsDetails(apiToken, driverId, day);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      List<Datum> bookingDetails = response!.data;

      for (final bookingDetail in bookingDetails) {
        print(bookingDetail.bookingId);
        print('----------booking number ${bookingDetail.bookingNumber}');
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
    if (acknowledgeResponse != null) {
      AcknowledgeBooking? bookingDetails = acknowledgeResponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('Notice', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white);

      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  ONtheWayBooking? onTheWayResponse;

  void _onthewayBooking(String? apiToken, int? driverId, int? bookingId) async {
    onTheWayResponse = await apiService.onTheWay(apiToken, driverId, bookingId);
    print('---------response $onTheWayResponse');
    if (onTheWayResponse != null) {
      ONtheWayBooking? bookingDetails = onTheWayResponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white);

      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  WaitingBooking? waitingResponse;

  void _waitingBooking(String? apiToken, int? driverId, int? bookingId) async {
    waitingResponse =
        await apiService.waitingBooking(apiToken, driverId, bookingId);
    print('---------response $waitingResponse');
    if (waitingResponse != null) {
      WaitingBooking? bookingDetails = waitingResponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white);
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  PickUpBooking? pickupresponse;

  void _pickUpBooking(String? apiToken, int? driverId, int? bookingId) async {
    pickupresponse =
        await apiService.pickUpBooking(apiToken, driverId, bookingId);
    print('---------response $waitingResponse');
    if (pickupresponse != null) {
      PickUpBooking? bookingDetails = pickupresponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white);
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fatch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  DropOfBooking? dropOffResponse;

  void _dropOffBooking(
      String? note, String? apiToken, int? driverId, int? bookingId) async {
    dropOffResponse =
        await apiService.dropOfBooking(note, apiToken, driverId, bookingId);
    print('---------response $waitingResponse');
    if (dropOffResponse != null) {
      DropOfBooking? bookingDetails = dropOffResponse;

      // for (final bookingDetail in bookingDetails) {
      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white);
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
    if (viewBookingResponse != null && viewBookingResponse?.success == 1) {
      List<DataDetails> viewBookingDetials = viewBookingResponse!.data;

      for (final viewBookingDetials in viewBookingDetials) {
        Get.to(() => ViewBookingDetailsScreen(
              bookingid: viewBookingDetials.bookingNumber,
              comments: viewBookingDetials.comments,
              customer: viewBookingDetials.customer,
              destination: viewBookingDetials.destination,
              mobileNo: viewBookingDetials.mobileNo,
              noteToDriver: viewBookingDetials.noteToDriver,
              personInCharge: viewBookingDetials.personIncharge,
              pessanger: viewBookingDetials.pax,
              pessengerName: viewBookingDetials.paxName,
              pickUpDatetime: viewBookingDetials.dateTime,
              pickupLocation: viewBookingDetials.pickupLocation,
              trevalpurpose: viewBookingDetials.reason,
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
                themeController.toggleTheme(!themeController.isDarkMode.value);
              },
            ),
          ],
        ),
        body: _buildBody(), // Add this line to include the body
      );
    });
  }

  Color? _getCardColor(String? tripStatus) {
    switch (tripStatus) {
      case 'Upcoming':
        return const Color.fromARGB(255, 240, 176, 155);

      case 'PickedUp':
        return const Color.fromARGB(
            255, 86, 140, 88); // Change to the desired color for 'Waiting'
      case 'OnTheWay':
        return Colors.lightGreen; // Change to the desired color for 'OnTheWay'
      case 'Waiting':
        return const Color.fromARGB(255, 245, 112, 112);
      default:
        return Colors.deepPurple[50]; // Default color
    }
  }

  Widget _buildBody() {
    double screenWidth = MediaQuery.of(context).size.width;
    if (response != null && response!.success == 1) {
      List<Datum> bookingDetails = response!.data;

      return bookingDetails.isEmpty?const Center(child: Text('There is no booking', style: TextStyle(fontWeight: FontWeight.bold),)):
      ListView.builder(
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
                color: _getCardColor(bookingDetail.tripStatus),
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
                            Text('Vehicle:',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                )),
                            Text('Date/Time:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('PickUp Location:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('Pax:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('Reason:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('Destination:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('Booking:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
                            Text('Status:',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black)),
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
                            Text(
                              '${bookingDetail.vehicleNumber}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                            Container(
                              width: screenWidth * 0.350,
                              child: Text(
                                '${bookingDetail.dateTime}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.350,
                              child: Text(
                                '${bookingDetail.pickupLocation}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ),
                            Text(
                              '${bookingDetail.pax}',
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                            Container(
                              width: screenWidth * 0.350,
                              child: Text(
                                '${bookingDetail.reason}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.350,
                              child: Text(
                                '${bookingDetail.destination}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                            ),
                            Text(
                              '${bookingDetail.bookingNumber}',
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                            Text(
                              '${bookingDetail.tripStatus}',
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    backgroundColor: AppColors.primaryColor,
                                    title: 'Notice',
                                    titleStyle:
                                        const TextStyle(color: Colors.white),
                                    content: Column(
                                      children: [
                                        if (!isToday(
                                            "${bookingDetail.dateTime}"))
                                          ElevatedButton(
                                            onPressed: () {
                                              _acknowledgeMessage(
                                                  apiToken,
                                                  driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                              // Trigger screen refresh
                                              setState(() {
                                                getData(); // You can call any method that refreshes your screen data
                                              });
                                            },
                                            child: const Text('Acknowledge'),
                                          ),
                                        if (isToday(
                                                "${bookingDetail.dateTime}") &&
                                            bookingDetail.tripStatus ==
                                                'Upcoming')
                                          ElevatedButton(
                                            onPressed: () {
                                              _onthewayBooking(
                                                  apiToken,
                                                  driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                              // Trigger screen refresh
                                              setState(() {
                                                getData(); // You can call any method that refreshes your screen data
                                              });
                                            },
                                            child: const Text('On the Way'),
                                          ),
                                        if (bookingDetail.tripStatus ==
                                            'OnTheWay')
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _waitingBooking(
                                                      apiToken,
                                                      driverId,
                                                      bookingDetail.bookingId);
                                                  Navigator.pop(context);
                                                  // Trigger screen refresh
                                                  setState(() {
                                                    getData(); // You can call any method that refreshes your screen data
                                                  });
                                                },
                                                child: const Text('Waiting'),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _pickUpBooking(
                                                      apiToken,
                                                      driverId,
                                                      bookingDetail.bookingId);
                                                  Navigator.pop(context);
                                                  // Trigger screen refresh
                                                  setState(() {
                                                    getData(); // You can call any method that refreshes your screen data
                                                  });
                                                },
                                                child: const Text('Pickup'),
                                              ),
                                            ],
                                          ),
                                        if (bookingDetail.tripStatus ==
                                            'Waiting')
                                          Column(children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                _pickUpBooking(
                                                    apiToken,
                                                    driverId,
                                                    bookingDetail.bookingId);
                                                Navigator.pop(context);
                                                // Trigger screen refresh
                                                setState(() {
                                                  getData(); // You can call any method that refreshes your screen data
                                                });
                                              },
                                              child: const Text('Pickup'),
                                            ),
                                          ]),
                                        if (bookingDetail.tripStatus ==
                                            'PickedUp')
                                          ElevatedButton(
                                            onPressed: () {
                                              _dropOffBooking(
                                                  'a',
                                                  apiToken,
                                                  driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                              // Trigger screen refresh
                                              setState(() {
                                                getData(); // You can call any method that refreshes your screen data
                                              });
                                            },
                                            child: const Text('Dropoff'),
                                          ),
                                      ],
                                    ));
                              },
                              icon: const Icon(Icons.settings),
                            )
                          ],
                        ),
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

  bool isToday(String dateTime) {
    DateTime today = DateTime.now();
    DateTime bookingDate = DateTime.parse(dateTime);
    return today.year == bookingDate.year &&
        today.month == bookingDate.month &&
        today.day == bookingDate.day;
  }
}
