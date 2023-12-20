// To parse this JSON data, do
//
//     final viewPreStartQuestion = viewPreStartQuestionFromJson(jsonString);

// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';

ViewPreStartQuestion viewPreStartQuestionFromJson(String str) => ViewPreStartQuestion.fromJson(json.decode(str));

String viewPreStartQuestionToJson(ViewPreStartQuestion data) => json.encode(data.toJson());

class ViewPreStartQuestion {
    int success;
    String message;
    ViewData data;

    ViewPreStartQuestion({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ViewPreStartQuestion.fromJson(Map<String, dynamic> json) => ViewPreStartQuestion(
        success: json["success"],
        message: json["message"],
        data: ViewData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class ViewData {
    int prestartId;
    String driver;
    String vehicle;
    String mileage;
    String location;
    List<Question> questions;
    List<String> photos;

    ViewData({
        required this.prestartId,
        required this.driver,
        required this.vehicle,
        required this.mileage,
        required this.location,
        required this.questions,
        required this.photos,
    });

    factory ViewData.fromJson(Map<String, dynamic> json) => ViewData(
        prestartId: json["prestart_id"],
        driver: json["driver"],
        vehicle: json["vehicle"],
        mileage: json["mileage"],
        location: json["location"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        photos: List<String>.from(json["photos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "prestart_id": prestartId,
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
    PassOrFail passOrFail;
    dynamic note;

    Question({
        required this.questionId,
        required this.question,
        required this.passOrFail,
        required this.note,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        question: json["question"],
        passOrFail: passOrFailValues.map[json["pass_or_fail"]]!,
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "pass_or_fail": passOrFailValues.reverse[passOrFail],
        "note": note,
    };
}

enum PassOrFail {
    FAIL,
    PASS
}

final passOrFailValues = EnumValues({
    "Fail": PassOrFail.FAIL,
    "Pass": PassOrFail.PASS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
