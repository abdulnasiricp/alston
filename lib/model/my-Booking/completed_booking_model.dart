// To parse this JSON data, do
//
//     final shiftDetails = shiftDetailsFromJson(jsonString);

import 'dart:convert';

ShiftDetails shiftDetailsFromJson(String str) => ShiftDetails.fromJson(json.decode(str));

String shiftDetailsToJson(ShiftDetails data) => json.encode(data.toJson());

class ShiftDetails {
    int success;
    String message;
    List<CompletedData> data;

    ShiftDetails({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ShiftDetails.fromJson(Map<String, dynamic> json) => ShiftDetails(
        success: json["success"],
        message: json["message"],
        data: List<CompletedData>.from(json["data"].map((x) => CompletedData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CompletedData {
    dynamic bookingId;
    dynamic bookingNumber;
    dynamic vehicleNumber;
    dynamic customer;
    DateTime dateTime;
    DateTime date;
    dynamic time;
    dynamic pickupLocation;
    dynamic destination;
    dynamic reason;
    dynamic pax;
    dynamic tripStatus;
    dynamic driverStatus;
    dynamic paxName;
    dynamic noteToDriver;
    dynamic personIncharge;
    dynamic mobileNo;
    dynamic comments;
    dynamic noteByDriver;
    DateTime startTime;
    DateTime endTime;
    dynamic hours;

    CompletedData({
        required this.bookingId,
        required this.bookingNumber,
        required this.vehicleNumber,
        required this.customer,
        required this.dateTime,
        required this.date,
        required this.time,
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
        required this.noteByDriver,
        required this.startTime,
        required this.endTime,
        required this.hours,
    });

    factory CompletedData.fromJson(Map<String, dynamic> json) => CompletedData(
        bookingId: json["booking_id"],
        bookingNumber: json["booking_number"],
        vehicleNumber: json["vehicle_number"],
        customer: json["customer"],
        dateTime: DateTime.parse(json["date_time"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
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
        noteByDriver: json["note_by_driver"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        hours: json["hours"],
    );

    Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "booking_number": bookingNumber,
        "vehicle_number": vehicleNumber,
        "customer": customer,
        "date_time": dateTime.toIso8601String(),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
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
        "note_by_driver": noteByDriver,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "hours": hours,
    };
}
