// To parse this JSON data, do
//
//     final locationDetials = locationDetialsFromJson(jsonString);

import 'dart:convert';

List<LocationDetials> locationDetialsFromJson(String str) => List<LocationDetials>.from(json.decode(str).map((x) => LocationDetials.fromJson(x)));

String locationDetialsToJson(List<LocationDetials> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationDetials {
    String plate;
    String speed;
    String odometer;
    String latitude;
    String longitude;
    String address;
    String deviceId;
    DateTime eventDate;
    String uniqueId;
    String imei;
    String userTimeZone;

    LocationDetials({
        required this.plate,
        required this.speed,
        required this.odometer,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.deviceId,
        required this.eventDate,
        required this.uniqueId,
        required this.imei,
        required this.userTimeZone,
    });

    factory LocationDetials.fromJson(Map<String, dynamic> json) => LocationDetials(
        plate: json["plate"],
        speed: json["speed"],
        odometer: json["odometer"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        deviceId: json["deviceId"],
        eventDate: DateTime.parse(json["eventDate"]),
        uniqueId: json["uniqueId"],
        imei: json["imei"],
        userTimeZone: json["userTimeZone"],
    );

    Map<String, dynamic> toJson() => {
        "plate": plate,
        "speed": speed,
        "odometer": odometer,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "deviceId": deviceId,
        "eventDate": eventDate.toIso8601String(),
        "uniqueId": uniqueId,
        "imei": imei,
        "userTimeZone": userTimeZone,
    };
}
