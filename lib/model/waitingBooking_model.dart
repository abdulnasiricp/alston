// To parse this JSON data, do
//
//     final waitingBooking = waitingBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

WaitingBooking waitingBookingFromJson(String str) => WaitingBooking.fromJson(json.decode(str));

String waitingBookingToJson(WaitingBooking data) => json.encode(data.toJson());

class WaitingBooking {
    int success;
    String message;
    String data;

    WaitingBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory WaitingBooking.fromJson(Map<String, dynamic> json) => WaitingBooking(
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
