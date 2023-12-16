// To parse this JSON data, do
//
//     final pickUpBooking = pickUpBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PickUpBooking pickUpBookingFromJson(String str) => PickUpBooking.fromJson(json.decode(str));

String pickUpBookingToJson(PickUpBooking data) => json.encode(data.toJson());

class PickUpBooking {
    int success;
    String message;
    String data;

    PickUpBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory PickUpBooking.fromJson(Map<String, dynamic> json) => PickUpBooking(
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
