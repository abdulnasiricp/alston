class LoginResponse {
  final int success;
  final String message;
  final UserData data;

  LoginResponse(
      {required this.success, required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: _toInt(json['success']),
      message: json['message'],
      data: UserData.fromJson(json['data']['userinfo']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0; // Default to 0 if parsing fails
    }
    throw FormatException('Unable to convert $value to int');
  }
}

class UserData {
  final int driverId;
  final String apiToken;
  final String userName;
  final String phone;
  final String mobile;
  final String email;
  final String busNumber;
  final int vehicleId;
  final String timestamp;
  final List<AssignedRoute> assignedRoutes;

  UserData({
    required this.driverId,
    required this.apiToken,
    required this.userName,
    required this.phone,
    required this.mobile,
    required this.email,
    required this.busNumber,
    required this.vehicleId,
    required this.timestamp,
    required this.assignedRoutes,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    var routeList = json['assigned_routes'] as List;
    List<AssignedRoute> routes =
        routeList.map((i) => AssignedRoute.fromJson(i)).toList();

    return UserData(
      driverId: LoginResponse._toInt(json['driver_id']),
      apiToken: json['api_token'],
      userName: json['user_name'],
      phone: json['phone'],
      mobile: json['mobile'],
      email: json['email'],
      busNumber: json['bus_number'],
      vehicleId: LoginResponse._toInt(json['vehicle_id']),
      timestamp: json['timestamp'],
      assignedRoutes: routes,
    );
  }
}

class AssignedRoute {
  final int routeId;
  final String number;
  final String name;
  final String busNumber;
  final int vehicleId;

  AssignedRoute({
    required this.routeId,
    required this.number,
    required this.name,
    required this.busNumber,
    required this.vehicleId,
  });

  factory AssignedRoute.fromJson(Map<String, dynamic> json) {
    return AssignedRoute(
      routeId: LoginResponse._toInt(json['route_id']),
      number: json['number'],
      name: json['name'],
      busNumber: json['bus_number'],
      vehicleId: LoginResponse._toInt(json['vehicle_id']),
    );
  }
}
