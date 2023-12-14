// To parse this JSON data, do
//
//     final endShiftEosStep1 = endShiftEosStep1FromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

EndShiftEosStep1 endShiftEosStep1FromJson(String str) => EndShiftEosStep1.fromJson(json.decode(str));

String endShiftEosStep1ToJson(EndShiftEosStep1 data) => json.encode(data.toJson());

class EndShiftEosStep1 {
    int success;
    String message;
    Data data;

    EndShiftEosStep1({
        required this.success,
        required this.message,
        required this.data,
    });

    factory EndShiftEosStep1.fromJson(Map<String, dynamic> json) => EndShiftEosStep1(
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
    int eosId;

    Data({
        required this.eosId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        eosId: json["eos_id"],
    );

    Map<String, dynamic> toJson() => {
        "eos_id": eosId,
    };
}
