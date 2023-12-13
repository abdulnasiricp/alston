// To parse this JSON data, do
//
//     final submitQuestion = submitQuestionFromJson(jsonString);

import 'dart:convert';

SubmitQuestion submitQuestionFromJson(String str) => SubmitQuestion.fromJson(json.decode(str));

String submitQuestionToJson(SubmitQuestion data) => json.encode(data.toJson());

class SubmitQuestion {
    int success;
    String message;
    Data data;

    SubmitQuestion({
        required this.success,
        required this.message,
        required this.data,
    });

    factory SubmitQuestion.fromJson(Map<String, dynamic> json) => SubmitQuestion(
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
