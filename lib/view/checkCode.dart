// ignore_for_file: file_names
//  ViewBooking? viewBookingResponse;

//   void viewBooking(
//       String? apiToken, int? bookingId) async {
//     viewBookingResponse =
//         await apiService.viewBookingDetails(apiToken, bookingId);
//     print('---------response $acknowledgeResponse');
//     if (response != null) {
//       ViewBooking? bookingDetails = viewBookingResponse;

//       // for (final bookingDetail in bookingDetails) {
//       print(bookingDetails?.message);
//       Get.snackbar('', '${bookingDetails?.message}',
//           snackPosition: SnackPosition.TOP);
//       setState(() {});
//     } else {
//       // Login failed, show an error message
//       Get.snackbar('Error', 'Api data fatch failed.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }









//  Get.to(()=>ViewBookingDetials());
        // Get.defaultDialog(
        //     title: 'View Booking Details',
        //     content: Column(
        //       children: [
        //         Text("${viewBookingDetials.destination}"),
        //         Text("${viewBookingDetials.bookingId}"),
        //         Text("${viewBookingDetials.comments}"),
        //         Text("${viewBookingDetials.customer}"),
        //         Text("${viewBookingDetials.dateTime}"),
        //         Text("${viewBookingDetials.driverStatus}"),
        //         Text("${viewBookingDetials.mobileNo}"),
        //         Text("${viewBookingDetials.noteToDriver}"),
        //         Text("${viewBookingDetials.pax}"),
        //         Text("${viewBookingDetials.paxName}"),
        //         Text("${viewBookingDetials.bookingNumber}"),
        //         Text("${viewBookingDetials.personIncharge}"),
        //         Text("${viewBookingDetials.pickupLocation}"),
        //         Text("${viewBookingDetials.reason}"),
        //         Text("${viewBookingDetials.tripStatus}"),
        //       ],
        //     ));