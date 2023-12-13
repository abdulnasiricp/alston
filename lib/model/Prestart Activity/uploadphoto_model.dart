// To parse this JSON data, do
//
//     final uploadPhoto = uploadPhotoFromJson(jsonString);

import 'dart:convert';

UploadPhoto uploadPhotoFromJson(String str) => UploadPhoto.fromJson(json.decode(str));

String uploadPhotoToJson(UploadPhoto data) => json.encode(data.toJson());

class UploadPhoto {
    int success;
    String message;
    String data;

    UploadPhoto({
        required this.success,
        required this.message,
        required this.data,
    });

    factory UploadPhoto.fromJson(Map<String, dynamic> json) => UploadPhoto(
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
