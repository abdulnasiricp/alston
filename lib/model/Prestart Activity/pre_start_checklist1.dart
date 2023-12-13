class PrestartResponseSTEP1 {
  int success;
  String message;
  PrestartData data;

  PrestartResponseSTEP1({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PrestartResponseSTEP1.fromJson(Map<String, dynamic> json) {
    return PrestartResponseSTEP1(
      success: json['success'],
      message: json['message'],
      data: PrestartData.fromJson(json['data']),
    );
  }
}

class PrestartData {
  int prestartId;

  PrestartData({
    required this.prestartId,
  });

  factory PrestartData.fromJson(Map<String, dynamic> json) {
    return PrestartData(
      prestartId: json['prestart_id'],
    );
  }
}
