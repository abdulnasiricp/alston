class Vehicle {
  final int vehicleId;
  final String vehicle;

  Vehicle({
    required this.vehicleId,
    required this.vehicle,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleId: json['vehicle_id'],
      vehicle: json['vehicle'],
    );
  }
}

class Question {
  final int questionId;
  final String question;

  Question({
    required this.questionId,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
    );
  }
}

class Data {
  final List<Vehicle> vehicles;
  final List<Question> questions;

  Data({
    required this.vehicles,
    required this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final vehicleList = (json['vehicles'] as List<dynamic>)
        .map((vehicleJson) => Vehicle.fromJson(vehicleJson))
        .toList();
    final questionList = (json['questions'] as List<dynamic>)
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();

    return Data(
      vehicles: vehicleList,
      questions: questionList,
    );
  }
}

class ApiResponse {
  final int success;
  final String message;
  final Data data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}
