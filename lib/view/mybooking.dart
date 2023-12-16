// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unused_element, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:alston/api/api_service.dart';
import 'package:alston/model/dropofBooking.dart';
import 'package:alston/model/my-Booking/acknowledge-booking_model.dart';
import 'package:alston/model/my-Booking/my_booking_model.dart';
import 'package:alston/model/my-Booking/viewBooking_model.dart';
import 'package:alston/model/onTheWayBooking_model.dart';
import 'package:alston/model/pickupBooking_model.dart';
import 'package:alston/model/waitingBooking_model.dart';
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
        Get.defaultDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: 'Booking Details',
            titleStyle: const TextStyle(color: Colors.white),
            content: Column(
              children: [
                const Divider(
                  color: Colors.white,
                  height: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Booking:'),
                          Text("${viewBookingDetials.bookingNumber}")
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pickup Date & time:'),
                          Text("${viewBookingDetials.dateTime}")
                        ],
                      )
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Destination'),
                        Text(
                          "${viewBookingDetials.destination}",
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PickUp Location'),
                        Text("${viewBookingDetials.pickupLocation}")
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Customer:'),
                        Text("${viewBookingDetials.customer}")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Travel Purpose'),
                        Text("${viewBookingDetials.reason}")
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Person in Charge'),
                        Text(
                          "${viewBookingDetials.personIncharge}",
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Passenger:'),
                        Text("${viewBookingDetials.pax}")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mobile #'),
                        Text("${viewBookingDetials.mobileNo}")
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Passenger Name:'),
                        Container(
                          width: 150, // Set a fixed width for the container
                          child: Text(
                            "${viewBookingDetials.paxName}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Note to Driver:'),
                        Container(
                          width: 100, // Set a fixed width for the container
                          child: Text(
                            "${viewBookingDetials.noteToDriver}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Comments:'),
                        Container(
                          width: 150, // Set a fixed width for the container
                          child: Text(
                            "${viewBookingDetials.comments}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                            Container(
                              width: 100,
                              child: Text(
                                '${bookingDetail.dateTime}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                '${bookingDetail.pickupLocation}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
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
                            Container(
                              width: 100,
                              child: Text(
                                '${bookingDetail.destination}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
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
                                backgroundColor: Colors.deepPurple,
                                title: 'Notice',
                                titleStyle:
                                    const TextStyle(color: Colors.white),
                                content: 
                              Column(
                                  children: [
                                 if (!isToday("${bookingDetail.dateTime}"))
                                    ElevatedButton(
                                      onPressed: () {
                                        _acknowledgeMessage(apiToken, driverId,
                                            bookingDetail.bookingId);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Acknowledge'),
                                    ),
                                    if (isToday("${bookingDetail.dateTime}") &&
                                        bookingDetail.tripStatus == 'Upcoming')
                                      ElevatedButton(
                                        onPressed: () {
                                          _onthewayBooking(apiToken, driverId,
                                              bookingDetail.bookingId);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('On the Way'),
                                      ),

                                    if (bookingDetail.tripStatus == 'OnTheWay')
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              _waitingBooking(
                                                  apiToken,
                                                  driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Waiting'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _pickUpBooking(apiToken, driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Pickup'),
                                          ),
                                        ],
                                      ),
                                      
                                      if (bookingDetail.tripStatus == 'Waiting')
                                      Column(
                                        children: [
                                          ElevatedButton(
                                           onPressed: () {
                                              _pickUpBooking(apiToken, driverId,
                                                  bookingDetail.bookingId);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Pickup'),
                                          ),

                                    if (bookingDetail.tripStatus == 'PickedUp')
                                      ElevatedButton(
                                        onPressed: () {
                                          _dropOffBooking(
                                              '',
                                              apiToken,
                                              driverId,
                                              bookingDetail.bookingId);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Dropoff'),
                                      ),
                                  ],
                                ),
                                  ]
                              ));
                            },

                            icon: const Icon(Icons.settings),
                          )
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

  bool isToday(String dateTime) {
    DateTime today = DateTime.now();
    DateTime bookingDate = DateTime.parse(dateTime);

    return today.year == bookingDate.year &&
        today.month == bookingDate.month &&
        today.day == bookingDate.day;
  }
}
