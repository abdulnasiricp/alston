class ApiResponse {
  int success;
  String message;
  Data data;

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

class Data {
  int prestartId;
  String driver;
  String vehicle;
  String mileage;
  String location;
  List<Question> questions;
  List<String> photos;

  Data({
    required this.prestartId,
    required this.driver,
    required this.vehicle,
    required this.mileage,
    required this.location,
    required this.questions,
    required this.photos,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var questionList = json['questions'] as List;
    List<Question> questionObjects = questionList.map((questionJson) {
      return Question.fromJson(questionJson);
    }).toList();

    var photoList = json['photos'] as List;
    List<String> photoUrls = photoList.map((photoJson) {
      return photoJson.toString();
    }).toList();

    return Data(
      prestartId: json['prestart_id'],
      driver: json['driver'],
      vehicle: json['vehicle'],
      mileage: json['mileage'],
      location: json['location'],
      questions: questionObjects,
      photos: photoUrls,
    );
  }
}

class Question {
  int questionId;
  String question;
  String passOrFail;
  dynamic note;

  Question({
    required this.questionId,
    required this.question,
    required this.passOrFail,
    this.note,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
      passOrFail: json['pass_or_fail'],
      note: json['note'],
    );
  }
}
