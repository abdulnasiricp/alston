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