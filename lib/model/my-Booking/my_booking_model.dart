// To parse this JSON data, do
//
//     final myBookingDetails = myBookingDetailsFromJson(jsonString);

import 'dart:convert';

MyBookingDetails myBookingDetailsFromJson(String str) => MyBookingDetails.fromJson(json.decode(str));

String myBookingDetailsToJson(MyBookingDetails data) => json.encode(data.toJson());

class MyBookingDetails {
    int success;
    String message;
    List<Datum> data;

    MyBookingDetails({
        required this.success,
        required this.message,
        required this.data,
    });

    factory MyBookingDetails.fromJson(Map<String, dynamic> json) => MyBookingDetails(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
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
    dynamic noteToDriver;
    String personIncharge;
    String mobileNo;
    dynamic comments;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bookingId: json["booking_id"],
        bookingNumber: json["booking_number"],
        vehicleNumber: json["vehicle_number"],
        customer: json["customer"],
        dateTime: DateTime.parse(json["date_time"]),
        pickupLocation: json["pickup_location"],
        destination: json["destination"],
        reason: json["reason"],
        pax: json["pax"],
        tripStatus: json["trip_status"],
        driverStatus: json["driver_status"],
        paxName: json["pax_name"],
        noteToDriver: json["note_to_driver"],
        personIncharge: json["person_incharge"],
        mobileNo: json["mobile_no"],
        comments: json["comments"],
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
