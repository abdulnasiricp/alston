// To parse this JSON data, do
//
//     final oNtheWayBooking = oNtheWayBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ONtheWayBooking oNtheWayBookingFromJson(String str) => ONtheWayBooking.fromJson(json.decode(str));

String oNtheWayBookingToJson(ONtheWayBooking data) => json.encode(data.toJson());

class ONtheWayBooking {
    int success;
    String message;
    String data;

    ONtheWayBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ONtheWayBooking.fromJson(Map<String, dynamic> json) => ONtheWayBooking(
        success: json["success"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
    };
}
