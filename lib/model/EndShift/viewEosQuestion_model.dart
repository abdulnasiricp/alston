// To parse this JSON data, do
//
//     final viewEndShiftQuestion = viewEndShiftQuestionFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ViewEndShiftQuestion viewEndShiftQuestionFromJson(String str) => ViewEndShiftQuestion.fromJson(json.decode(str));

String viewEndShiftQuestionToJson(ViewEndShiftQuestion data) => json.encode(data.toJson());

class ViewEndShiftQuestion {
    int success;
    String message;
    EndData data;

    ViewEndShiftQuestion({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ViewEndShiftQuestion.fromJson(Map<String, dynamic> json) => ViewEndShiftQuestion(
        success: json["success"],
        message: json["message"],
        data: EndData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class EndData {
    int eosId;
    String driver;
    String vehicle;
    String mileage;
    String location;
    List<Question> questions;
    List<dynamic> photos;

    EndData({
        required this.eosId,
        required this.driver,
        required this.vehicle,
        required this.mileage,
        required this.location,
        required this.questions,
        required this.photos,
    });

    factory EndData.fromJson(Map<String, dynamic> json) => EndData(
        eosId: json["eos_id"],
        driver: json["driver"],
        vehicle: json["vehicle"],
        mileage: json["mileage"],
        location: json["location"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        photos: List<dynamic>.from(json["photos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "eos_id": eosId,
        "driver": driver,
        "vehicle": vehicle,
        "mileage": mileage,
        "location": location,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x)),
    };
}

class Question {
    int questionId;
    String question;
    String passOrFail;
    String? note;

    Question({
        required this.questionId,
        required this.question,
        required this.passOrFail,
        required this.note,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        question: json["question"],
        passOrFail: json["pass_or_fail"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "pass_or_fail": passOrFail,
        "note": note,
    };
}
