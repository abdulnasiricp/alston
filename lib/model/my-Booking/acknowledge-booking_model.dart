// To parse this JSON data, do
//
//     final acknowledgeBooking = acknowledgeBookingFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AcknowledgeBooking acknowledgeBookingFromJson(String str) => AcknowledgeBooking.fromJson(json.decode(str));

String acknowledgeBookingToJson(AcknowledgeBooking data) => json.encode(data.toJson());

class AcknowledgeBooking {
    int success;
    String message;
    String data;

    AcknowledgeBooking({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AcknowledgeBooking.fromJson(Map<String, dynamic> json) => AcknowledgeBooking(
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
