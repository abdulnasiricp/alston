// To parse this JSON data, do
//
//     final confirmPassword = confirmPasswordFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ConfirmPassword confirmPasswordFromJson(String str) => ConfirmPassword.fromJson(json.decode(str));

String confirmPasswordToJson(ConfirmPassword data) => json.encode(data.toJson());

class ConfirmPassword {
    int success;
    String message;
    String data;

    ConfirmPassword({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ConfirmPassword.fromJson(Map<String, dynamic> json) => ConfirmPassword(
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
