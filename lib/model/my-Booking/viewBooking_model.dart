// To parse this JSON data, do
//
//     final viewBooking = viewBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ViewBooking viewBookingFromJson(String str) => ViewBooking.fromJson(json.decode(str));

String viewBookingToJson(ViewBooking data) => json.encode(data.toJson());

class ViewBooking {
    int success;
    String message;
    List<DataDetails> data;

    ViewBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ViewBooking.fromJson(Map<String, dynamic> json) => ViewBooking(
        success: json["success"],
        message: json["message"],
        data: List<DataDetails>.from(json["data"].map((x) => DataDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataDetails {
    int bookingId;
    int bookingNumber;
    String vehicleNumber;
    String customer;
    DateTime dateTime;
    String pickupLocation;
    String destination;
    String reason;
    int pax;
    String tripStatus;
    String driverStatus;
    String paxName;
    String noteToDriver;
    String personIncharge;
    String mobileNo;
    String comments;

    DataDetails({
        required this.bookingId,
        required this.bookingNumber,
        required this.vehicleNumber,
        required this.customer,
        required this.dateTime,
        required this.pickupLocation,
        required this.destination,
        required this.reason,
        required this.pax,
        required this.tripStatus,
        required this.driverStatus,
        required this.paxName,
        required this.noteToDriver,
        required this.personIncharge,
        required this.mobileNo,
        required this.comments,
    });

    factory DataDetails.fromJson(Map<String, dynamic> json) => DataDetails(
  bookingId: json["booking_id"] ?? 0,
  bookingNumber: json["booking_number"] ?? 0,
  vehicleNumber: json["vehicle_number"] ?? "",
  customer: json["customer"] ?? "",
  dateTime: json["date_time"] != null ? DateTime.parse(json["date_time"]) : DateTime.now(),
  pickupLocation: json["pickup_location"] ?? "",
  destination: json["destination"] ?? "",
  reason: json["reason"] ?? "",
  pax: json["pax"] ?? 0,
  tripStatus: json["trip_status"] ?? "",
  driverStatus: json["driver_status"] ?? "",
  paxName: json["pax_name"] ?? "",
  noteToDriver: json["note_to_driver"] ?? "",
  personIncharge: json["person_incharge"] ?? "",
  mobileNo: json["mobile_no"] ?? "",
  comments: json["comments"] ?? "",
);


    Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "booking_number": bookingNumber,
        "vehicle_number": vehicleNumber,
        "customer": customer,
        "date_time": dateTime.toIso8601String(),
        "pickup_location": pickupLocation,
        "destination": destination,
        "reason": reason,
        "pax": pax,
        "trip_status": tripStatus,
        "driver_status": driverStatus,
        "pax_name": paxName,
        "note_to_driver": noteToDriver,
        "person_incharge": personIncharge,
        "mobile_no": mobileNo,
        "comments": comments,
    };
}
