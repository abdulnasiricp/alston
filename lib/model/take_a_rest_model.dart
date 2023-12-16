// To parse this JSON data, do
//
//     final takeRest = takeRestFromJson(jsonString);

import 'dart:convert';

TakeRest takeRestFromJson(String str) => TakeRest.fromJson(json.decode(str));

String takeRestToJson(TakeRest data) => json.encode(data.toJson());

class TakeRest {
    int success;
    String message;
    Data data;

    TakeRest({
        required this.success,
        required this.message,
        required this.data,
    });

    factory TakeRest.fromJson(Map<String, dynamic> json) => TakeRest(
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
