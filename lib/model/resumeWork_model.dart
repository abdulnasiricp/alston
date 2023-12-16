// To parse this JSON data, do
//
//     final resumeWork = resumeWorkFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ResumeWork resumeWorkFromJson(String str) => ResumeWork.fromJson(json.decode(str));

String resumeWorkToJson(ResumeWork data) => json.encode(data.toJson());

class ResumeWork {
    int success;
    String message;
    Data data;

    ResumeWork({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ResumeWork.fromJson(Map<String, dynamic> json) => ResumeWork(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int restId;

    Data({
        required this.restId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        restId: json["rest_id"],
    );

    Map<String, dynamic> toJson() => {
        "rest_id": restId,
    };
}
