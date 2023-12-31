// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:alston/model/ConfirmPassword_model.dart';
import 'package:alston/model/EndShift/endShiftQuestion_model.dart';
import 'package:alston/model/EndShift/endShiftSubmitQuestion_model.dart';
import 'package:alston/model/EndShift/endShiftstep1_model.dart';
import 'package:alston/model/EndShift/viewEosQuestion_model.dart';
import 'package:alston/model/Prestart%20Activity/AskQuestion_model.dart';
import 'package:alston/model/Prestart%20Activity/pre_start_checklist1.dart';
import 'package:alston/model/Prestart%20Activity/pre_start_checklist2.dart';
import 'package:alston/model/Prestart%20Activity/question_model.dart';
import 'package:alston/model/Prestart%20Activity/uploadphoto_model.dart';
import 'package:alston/model/config_model.dart';
import 'package:alston/model/dropofBooking.dart';
import 'package:alston/model/my-Booking/acknowledge-booking_model.dart';
import 'package:alston/model/my-Booking/completed_booking_model.dart';
import 'package:alston/model/my-Booking/my_booking_model.dart';
import 'package:alston/model/my-Booking/viewBooking_model.dart';
import 'package:alston/model/onTheWayBooking_model.dart';
import 'package:alston/model/pickupBooking_model.dart';
import 'package:alston/model/resumeWork_model.dart';
import 'package:alston/model/take_a_rest_model.dart';
import 'package:alston/model/viewPreStartQuestion_model.dart';
import 'package:alston/model/waitingBooking_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Login/login_response_model.dart';



// *******************  Login **********************//

class ApiService extends GetxService {


  final String _baseUrl = 'https://cloudfront.safelineworld.com/api';

  Future<LoginResponse?> login(String? email, String? password) async {
    var url = Uri.parse('$_baseUrl/driver-login');
    try {
      var response = await http
          .post(url, body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var loginResponse = LoginResponse.fromJson(jsonResponse);

        // Save relevant information in SharedPreferences
        await _setLoginStatus(true);
        await _saveUserData(loginResponse.data);

        return loginResponse;
      } else {
        // Handle non-200 responses
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<void> _saveUserData(UserData userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('driverId', userData.driverId);
    await prefs.setString('apiToken', userData.apiToken);
    await prefs.setString('userName', userData.userName);
    await prefs.setInt('vehicleId', userData.vehicleId);
    await prefs.setString('busNumber', userData.busNumber);
    // await prefs.setInt('vehicleId', userData.vehicleId);
  
  }
  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> _setLoginStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  Future<void> logout() async {
    await _setLoginStatus(false); // Set login status to false on logout
    // Perform additional logout actions if necessary
  }

  
// 1. Get driver's prestart list
  Future<PrestartData?> getPrestartList(String apiToken, int driverId) async {
    var url = Uri.parse('$_baseUrl/prestart-list');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return PrestartData.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<QuestionDetails?> getVehicleAndQuestions(String apiToken) async {
    var url = Uri.parse('$_baseUrl/prestart');
    try {
      var response = await http.post(url, body: {'api_token': apiToken});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return QuestionDetails.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

    Future<EndShiftQuestion?> endShiftVehicleAndQuestions(String apiToken) async {
    var url = Uri.parse('$_baseUrl/eos');
    try {
      var response = await http.post(url, body: {'api_token': apiToken});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return EndShiftQuestion.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<PrestartResponseSTEP1?> savePrestartStep1(
      int? vehicleId,
      int? driverId,
      String apiToken,
      String mileage,
      String location,
      double latitude,
      double longitude) async {
    var url = Uri.parse('$_baseUrl/save-prestart');
    try {
      var response = await http.post(url, body: {
        'vehicle_id': vehicleId.toString(),
        'driver_id': driverId.toString(),
        'api_token': apiToken,
        'mileage': mileage.toString(),
        'location': location,
        'long': longitude.toString(),
        'lat': latitude.toString(),
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return PrestartResponseSTEP1.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


  Future<EndShiftEosStep1?> saveESOStep1(
      int? vehicleId,
      int? driverId,
      String apiToken,
      String mileage,
      String location,
      double latitude,
      double longitude) async {
    var url = Uri.parse('$_baseUrl/save-eos');
    try {
      var response = await http.post(url, body: {
        'vehicle_id': vehicleId.toString(),
        'driver_id': driverId.toString(),
        'api_token': apiToken,
        'mileage': mileage.toString(),
        'location': location,
        'long': longitude.toString(),
        'lat': latitude.toString(),
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return EndShiftEosStep1.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

   Future<SubmitQuestion?> savePrestartStep2(String? apiToken, int? prestartId, int? questionId, int? flag, String? note ) async {
    var url = Uri.parse('$_baseUrl/submit-prestart-question');
    try {
     var response = await http.post(url, body: {
        'api_token': apiToken,
        'prestart_id': prestartId.toString(),
        'question_id': questionId.toString(),
        'flag': flag.toString(),
        'note': note,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return SubmitQuestion.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


 Future<EndShiftQuestionSubmit?> saveEndshiftStep2(String? apiToken, int? eosId, int? questionId, int? flag, String? note ) async {
    var url = Uri.parse('$_baseUrl/submit-eos-question');
    try {
     var response = await http.post(url, body: {
        'api_token': apiToken,
        'eos_id': eosId.toString(),
        'question_id': questionId.toString(),
        'flag': flag.toString(),
        'note': note,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return EndShiftQuestionSubmit.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<UploadPhoto?> uploadPhoto(String apiToken, int prestartId, XFile photoFile) async {
  var url = Uri.parse('$_baseUrl/submit-prestart-photo');

  var request = http.MultipartRequest('POST', url)
    ..fields.addAll({
      'api_token': apiToken,
      'prestart_id': prestartId.toString(),
    })
    ..files.add(await http.MultipartFile.fromPath(
      'photo',
      photoFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

  var response = await request.send();

  // Convert the streamed response to a regular response
  http.Response regularResponse = await http.Response.fromStream(response);

  if (regularResponse.statusCode == 200) {
    var jsonResponse = json.decode(regularResponse.body);
    return UploadPhoto.fromJson(jsonResponse);
  } else {
    debugPrint('Error: ${regularResponse.statusCode}');
    return null;
  }
}





  Future<ApiResponse?> viewPrestartQuestions(String apiToken, int prestartId) async {
    var url = Uri.parse('$_baseUrl/view-prestart-questions');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'prestart_id': prestartId.toString(),
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ApiResponse.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


 Future<MyBookingDetails?> myBookingsDetails(String? apiToken, int? driverId,String? day ) async {
    var url = Uri.parse('$_baseUrl/my-bookings');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'day': day,
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return MyBookingDetails.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

Future<ShiftDetails?> shiftCompletedDetails(String apiToken, int? driverId,String day ) async {
    var url = Uri.parse('$_baseUrl/completed-bookings');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'day': day,
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ShiftDetails.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

 Future<AcknowledgeBooking?> acknowledgeDetails(String? apiToken, int? driverId,int? bookingId ) async {
    var url = Uri.parse('$_baseUrl/acknowledge-booking');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'booking_id': bookingId.toString(),
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return AcknowledgeBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

   Future<ViewBooking?> viewBookingDetails(String? apiToken, int? bookingId ) async {
    var url = Uri.parse('$_baseUrl/view-booking');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'booking_id': bookingId.toString(),
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ViewBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


  Future<TakeRest?> driverTakeRest( apiToken, int? driverId,int? vehicleId, odometer, location,  lat,long  ) async {
    var url = Uri.parse('$_baseUrl/start-rest');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id':driverId.toString(),
        'vehicle_id':vehicleId.toString(),
        'odometer':odometer,
        'location':location,
        'lat':lat,
        'long':long,

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return TakeRest.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

 Future<ResumeWork?> driverResumeWork( apiToken,int restId ) async {
    var url = Uri.parse('$_baseUrl/end-rest');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'rest_id': restId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ResumeWork.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }



 Future<ONtheWayBooking?> onTheWay(String? apiToken,int? driverId ,int? bookingId) async {
    var url = Uri.parse('$_baseUrl/on-the-way');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'booking_id': bookingId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ONtheWayBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


 Future<WaitingBooking?> waitingBooking(String? apiToken,int? driverId ,int? bookingId) async {
    var url = Uri.parse('$_baseUrl/waiting');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'booking_id': bookingId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return WaitingBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

   Future<PickUpBooking?> pickUpBooking(String? apiToken,int? driverId ,int? bookingId) async {
    var url = Uri.parse('$_baseUrl/pickup');
    try {
      var response = await http.post(url, body: {
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'booking_id': bookingId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return PickUpBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  Future<DropOfBooking?> dropOfBooking(String? note ,String? apiToken,int? driverId ,int? bookingId) async {
    var url = Uri.parse('$_baseUrl/dropoff');
    try {
      var response = await http.post(url, body: {
        'note': note,
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'booking_id': bookingId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return DropOfBooking.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }


Future<ConfirmPassword?> checkPassword(String? apiToken,int? driverId ,String? password) async {
    var url = Uri.parse('$_baseUrl/password-check');
    try {
      var response = await http.post(url, body: {
        
        'api_token': apiToken,
        'driver_id': driverId.toString(),
        'password': password,
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ConfirmPassword.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return null;
    }
  }

  
Future<ViewPreStartQuestion?> viewPresStartQuestion(dynamic apiToken,dynamic preStartId) async {
    var url = Uri.parse('$_baseUrl/view-prestart-questions');
    // try {
      var response = await http.post(url, body: {
        
        'api_token': apiToken,
        'prestart_id': preStartId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ViewPreStartQuestion.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    // } catch (e) {
    //   debugPrint('Exception caught: $e');
    //   return null;
    // }
  }

  
Future<ViewEndShiftQuestion?> viewEndShiftQuestion(dynamic apiToken,dynamic eosId) async {
    var url = Uri.parse('$_baseUrl/view-eos-questions');
    // try {
      var response = await http.post(url, body: {
        
        'api_token': apiToken,
        'eos_id': eosId.toString(),
       

      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ViewEndShiftQuestion.fromJson(jsonResponse);
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    // } catch (e) {
    //   debugPrint('Exception caught: $e');
    //   return null;
    // }
  }
}