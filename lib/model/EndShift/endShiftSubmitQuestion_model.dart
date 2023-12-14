// To parse this JSON data, do
//
//     final endShiftQuestionSubmit = endShiftQuestionSubmitFromJson(jsonString);

// ignore_for_file: file_names, duplicate_ignore

// ignore_for_file: file_names

import 'dart:convert';

EndShiftQuestionSubmit endShiftQuestionSubmitFromJson(String str) => EndShiftQuestionSubmit.fromJson(json.decode(str));

String endShiftQuestionSubmitToJson(EndShiftQuestionSubmit data) => json.encode(data.toJson());

class EndShiftQuestionSubmit {
    int success;
    String message;
    Data data;

    EndShiftQuestionSubmit({
        required this.success,
        required this.message,
        required this.data,
    });

    factory EndShiftQuestionSubmit.fromJson(Map<String, dynamic> json) => EndShiftQuestionSubmit(
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
    String questionId;

    Data({
        required this.questionId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        questionId: json["question_id"],
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
    };
}
