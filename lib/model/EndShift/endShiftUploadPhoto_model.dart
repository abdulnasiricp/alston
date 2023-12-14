// To parse this JSON data, do
//
//     final endShiftUploadPhoto = endShiftUploadPhotoFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

EndShiftUploadPhoto endShiftUploadPhotoFromJson(String str) => EndShiftUploadPhoto.fromJson(json.decode(str));

String endShiftUploadPhotoToJson(EndShiftUploadPhoto data) => json.encode(data.toJson());

class EndShiftUploadPhoto {
    int success;
    String message;
    String data;

    EndShiftUploadPhoto({
        required this.success,
        required this.message,
        required this.data,
    });

    factory EndShiftUploadPhoto.fromJson(Map<String, dynamic> json) => EndShiftUploadPhoto(
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
