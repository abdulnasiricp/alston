// To parse this JSON data, do
//
//     final dropOfBooking = dropOfBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

DropOfBooking dropOfBookingFromJson(String str) => DropOfBooking.fromJson(json.decode(str));

String dropOfBookingToJson(DropOfBooking data) => json.encode(data.toJson());

class DropOfBooking {
    int success;
    String message;
    String data;

    DropOfBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory DropOfBooking.fromJson(Map<String, dynamic> json) => DropOfBooking(
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
