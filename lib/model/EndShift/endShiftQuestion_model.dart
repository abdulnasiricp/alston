// To parse this JSON data, do
//
//     final endShiftQuestion = endShiftQuestionFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

EndShiftQuestion endShiftQuestionFromJson(String str) => EndShiftQuestion.fromJson(json.decode(str));

String endShiftQuestionToJson(EndShiftQuestion data) => json.encode(data.toJson());

class EndShiftQuestion {
    int success;
    String message;
    Data data;

    EndShiftQuestion({
        required this.success,
        required this.message,
        required this.data,
    });

    factory EndShiftQuestion.fromJson(Map<String, dynamic> json) => EndShiftQuestion(
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
    List<Vehicle> vehicles;
    List<Questions> questions;

    Data({
        required this.vehicles,
        required this.questions,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
        questions: List<Questions>.from(json["questions"].map((x) => Questions.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Questions {
    int questionId;
    String question;

    Questions({
        required this.questionId,
        required this.question,
    });

    factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        questionId: json["question_id"],
        question: json["question"],
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
    };
}

class Vehicle {
    int vehicleId;
    String vehicle;

    Vehicle({
        required this.vehicleId,
        required this.vehicle,
    });

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        vehicleId: json["vehicle_id"],
        vehicle: json["vehicle"],
    );

    Map<String, dynamic> toJson() => {
        "vehicle_id": vehicleId,
        "vehicle": vehicle,
    };
}
