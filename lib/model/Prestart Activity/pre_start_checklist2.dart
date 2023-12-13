// To parse this JSON data, do
//
//     final questionDetails = questionDetailsFromJson(jsonString);

import 'dart:convert';

QuestionDetails questionDetailsFromJson(String str) => QuestionDetails.fromJson(json.decode(str));

String questionDetailsToJson(QuestionDetails data) => json.encode(data.toJson());

class QuestionDetails {
    int success;
    String message;
    Data data;

    QuestionDetails({
        required this.success,
        required this.message,
        required this.data,
    });

    factory QuestionDetails.fromJson(Map<String, dynamic> json) => QuestionDetails(
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
    List<Question> questions;

    Data({
        required this.vehicles,
        required this.questions,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
    int questionId;
    String question;

    Question({
        required this.questionId,
        required this.question,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
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
