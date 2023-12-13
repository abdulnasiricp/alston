class PrestartData {
  int success;
  String message;
  List<PrestartItem> data;

  PrestartData(
      {required this.success, required this.message, required this.data});

  factory PrestartData.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as List;
    List<PrestartItem> prestartItems =
        data.map((item) => PrestartItem.fromJson(item)).toList();

    return PrestartData(
      success: json['success'],
      message: json['message'],
      data: prestartItems,
    );
  }
}

class PrestartItem {
  int prestartId;
  String driver;
  String vehicle;
  String mileage;
  String location;

  PrestartItem({
    required this.prestartId,
    required this.driver,
    required this.vehicle,
    required this.mileage,
    required this.location,
  });

  factory PrestartItem.fromJson(Map<String, dynamic> json) {
    return PrestartItem(
      prestartId: json['prestart_id'],
      driver: json['driver'],
      vehicle: json['vehicle'],
      mileage: json['mileage'],
      location: json['location'],
    );
  }
}
