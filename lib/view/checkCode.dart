// ignore_for_file: file_names
// // ignore_for_file: file_names
// //  ViewBooking? viewBookingResponse;

// //   void viewBooking(
// //       String? apiToken, int? bookingId) async {
// //     viewBookingResponse =
// //         await apiService.viewBookingDetails(apiToken, bookingId);
// //     print('---------response $acknowledgeResponse');
// //     if (response != null) {
// //       ViewBooking? bookingDetails = viewBookingResponse;

// //       // for (final bookingDetail in bookingDetails) {
// //       print(bookingDetails?.message);
// //       Get.snackbar('', '${bookingDetails?.message}',
// //           snackPosition: SnackPosition.TOP);
// //       setState(() {});
// //     } else {
// //       // Login failed, show an error message
// //       Get.snackbar('Error', 'Api data fatch failed.',
// //           snackPosition: SnackPosition.BOTTOM);
// //     }
// //   }









// //  Get.to(()=>ViewBookingDetials());
//         // Get.defaultDialog(
//         //     title: 'View Booking Details',
//         //     content: Column(
//         //       children: [
//         //         Text("${viewBookingDetials.destination}"),
//         //         Text("${viewBookingDetials.bookingId}"),
//         //         Text("${viewBookingDetials.comments}"),
//         //         Text("${viewBookingDetials.customer}"),
//         //         Text("${viewBookingDetials.dateTime}"),
//         //         Text("${viewBookingDetials.driverStatus}"),
//         //         Text("${viewBookingDetials.mobileNo}"),
//         //         Text("${viewBookingDetials.noteToDriver}"),
//         //         Text("${viewBookingDetials.pax}"),
//         //         Text("${viewBookingDetials.paxName}"),
//         //         Text("${viewBookingDetials.bookingNumber}"),
//         //         Text("${viewBookingDetials.personIncharge}"),
//         //         Text("${viewBookingDetials.pickupLocation}"),
//         //         Text("${viewBookingDetials.reason}"),
//         //         Text("${viewBookingDetials.tripStatus}"),
//         //       ],
//         //     ));






//         // ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_string_interpolations, unused_element, use_build_context_synchronously, non_constant_identifier_names

// import 'dart:convert';
// import 'package:alston/model/ConfirmPassword_model.dart';
// import 'package:alston/model/Prestart%20Activity/AskQuestion_model.dart';
// import 'package:http/http.dart' as http;

// import 'package:alston/api/api_service.dart';
// import 'package:alston/model/Prestart%20Activity/pre_start_checklist2.dart';
// import 'package:alston/model/Prestart%20Activity/uploadphoto_model.dart';
// import 'package:alston/utils/appcolors.dart';
// import 'package:alston/widgets/customelevatedbutton.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:alston/utils/theme_controller.dart';
// import 'package:http_parser/http_parser.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckList extends StatefulWidget {
//   final String apiToken;
//   final int preStartId;
//   const CheckList({Key? key, required this.apiToken, required this.preStartId})
//       : super(key: key);

//   @override
//   State<CheckList> createState() => _CheckListState();
// }

// class _CheckListState extends State<CheckList> {
//   final ApiService apiService = Get.put(ApiService());

//   late int? driverId;
//   late int? vehicleId;
//   late String apiToken = '';
//   LoadData() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     driverId = sp.getInt('driverId');
//     vehicleId = sp.getInt('vehicleId');
//     apiToken = sp.getString('apiToken') ?? "";
//     print(driverId);
//     print(vehicleId);
//     print(apiToken);
//     setState(() {});
//   }

//   getData() async {
//     await LoadData();
//   }

//   QuestionDetails? response;
//   List<Question> questionList = [];

//   Future<void> _questionList(String apiToken) async {
//     response = await apiService.getVehicleAndQuestions(apiToken);
//     print('---------response $response');
//     if (response != null && response?.success == 1) {
//       questionList = response!.data.questions;

//       setState(() {});
//     } else {
//       // Login failed, show an error message
//       Get.snackbar('Error', 'Api data fetch failed.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   TextEditingController questionController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   bool isCorrectSelected = false;
//   bool isWrongSelected = false;
//   bool onOptionSelected = false;

// //*******************************
//   SubmitQuestion? submitResponse;

//   void _submitChecklist(String? apiToken, int? prestartId, int? questionId,
//       int? flag, String? note) async {
//     submitResponse = await apiService.savePrestartStep2(
//         apiToken, prestartId, questionId, flag, note);
//     print('---------response $submitResponse');
//     if (submitResponse != null) {
//       print('----------$submitResponse');
//       SubmitQuestion? bookingDetails = submitResponse;

//       print(bookingDetails?.message);
//       Get.snackbar('', '${bookingDetails?.message}',
//           backgroundColor: Colors.deepPurple,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP);
//       setState(() {});
//     } else {
//       // Login failed, show an error message
//       Get.snackbar('Error', 'Api data fetch failed.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   ConfirmPassword? passwordResponse;

//   void _passwordCheck(String? apiToken, int? driverId, String? password) async {
//     passwordResponse =
//         await apiService.checkPassword(apiToken, driverId, password);
//     print('---------response $passwordResponse');
//     if (passwordResponse != null) {
//       print('----------$passwordResponse');
//       ConfirmPassword? bookingDetails = passwordResponse;

//       print(bookingDetails?.message);
//       Get.snackbar('Notice', '${bookingDetails?.message}',
//           backgroundColor: Colors.deepPurple,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP);
//       setState(() {});
//     } else {
//       // Login failed, show an error message
//       Get.snackbar('Error', 'Api data fetch failed.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   //*********************************
//   UploadPhoto? uploadphotoResponse;
//   final String _baseUrl = 'https://cloudfront.safelineworld.com/api';

//   void _uploadPhoto(String apiToken, int prestartId, XFile photoFile) async {
//     var url = Uri.parse('$_baseUrl/submit-prestart-photo');

//     try {
//       var request = http.MultipartRequest('POST', url)
//         ..fields.addAll({
//           'api_token': apiToken,
//           'prestart_id': prestartId.toString(),
//         })
//         ..files.add(await http.MultipartFile.fromPath(
//           'photo',
//           photoFile.path,
//           contentType: MediaType('image', 'jpeg'),
//         ));

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         // Successful upload
//         var jsonResponse = json.decode(await response.stream.bytesToString());
//         UploadPhoto uploadPhoto = UploadPhoto.fromJson(jsonResponse);

//         // Handle the response as needed
//         print('Upload Success: ${uploadPhoto.message}');
//         Get.snackbar('', '${uploadPhoto.message}',
//             backgroundColor: Colors.deepPurple,
//             colorText: Colors.white,
//             snackPosition: SnackPosition.TOP);
//       } else {
//         // Handle non-200 response
//         print('Upload Error: ${response.statusCode}');
//         Get.snackbar('Error', 'Failed to upload photo',
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Exception caught: $e');
//       Get.snackbar('Error', 'Failed to upload photo',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     print('------->------>${widget.apiToken}');
//     getData();
//     _questionList('${widget.apiToken}').then((_) {
//       // Initialize selectedOptions list with false
//       selectedOptions = List.generate(questionList.length, (index) => null);
//     });
//   }

//   List<bool?> selectedOptions = [];

//   late bool isAllQuestionsDone = false;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     // Adjust icon size and spacing based on screen size
//     double iconSize = screenWidth * 0.075; // e.g., 7.5% of screen width
//     double spaceBetween = screenHeight * 0.02; //
//     final ThemeController themeController = Get.find<ThemeController>();

//     return Obx(() => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('Pre-Start Checklist', style: GoogleFonts.lato()),
//           backgroundColor: themeController.isDarkMode.value
//               ? AppColors.primaryColor
//               : AppColors.backgroundColors,
//           actions: [
//             IconButton(
//               icon: Icon(
//                 themeController.isDarkMode.value
//                     ? Icons.light_mode // Icon for light mode
//                     : Icons.dark_mode,
//                 color: themeController.isDarkMode.value
//                     ? AppColors.darkModeIcon
//                     : AppColors.primaryColor,
//               ),
//               onPressed: () {
//                 // Toggle the theme
//                 themeController.toggleTheme(!themeController.isDarkMode.value);
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: isAllQuestionsDone
//                   ? Center(
//                       child: Text(
//                         'All questions for today are done!',
//                         style: TextStyle(
//                           color: Colors.green, // Change color as needed
//                           fontSize: screenWidth * 0.06,
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemCount: questionList.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: SizedBox(
//                             width: screenWidth * 0.8,
//                             height: screenHeight * 0.5,
//                             child: Card(
//                               elevation: 1,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               color: themeController.isDarkMode.value
//                                   ? AppColors.primaryColor
//                                   : AppColors.backgroundColors,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   top: screenWidth * 0.1,
//                                   left: screenWidth * 0.03,
//                                   right: screenWidth * 0.02,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '${questionList[index].questionId}#.',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: screenWidth * 0.05,
//                                           ).merge(GoogleFonts.josefinSans()),
//                                         ),
//                                         Flexible(
//                                           child: Text(
//                                             '${questionList[index].question}',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: screenWidth * 0.05,
//                                             ).merge(GoogleFonts.josefinSans()),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: screenHeight * 0.04),
//                                     Text("Please Submit the  Following:",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: screenWidth * 0.04,
//                                         )),
//                                     SizedBox(height: screenHeight * 0.04),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               _buildIcon(
//                                                 Icons.check,
//                                                 selectedOptions[index] == true,
//                                                 Colors.green,
//                                                 () {
//                                                   setState(() {
//                                                     if (selectedOptions[
//                                                             index] ==
//                                                         true) {
//                                                       selectedOptions[index] =
//                                                           null; // Change to white
//                                                     } else {
//                                                       selectedOptions[index] =
//                                                           true; // Change to green
//                                                     }
//                                                     Get.snackbar(
//                                                         'Question #${questionList[index].questionId}',
//                                                         'Question Pass ',
//                                                         colorText: Colors.white,
//                                                         backgroundColor:
//                                                             Colors.deepPurple,
//                                                         // animationDuration: Duration(microseconds: 500),
//                                                         duration: const Duration(
//                                                             milliseconds: 800));
//                                                   });
//                                                 },
//                                                 iconSize,
//                                                 // "Yes",
//                                                 index,
//                                               ),
//                                               SizedBox(width: spaceBetween),
//                                               _buildIcon(
//                                                 Icons.close,
//                                                 selectedOptions[index] == false,
//                                                 Colors.red,
//                                                 () {
//                                                   setState(() {
//                                                     if (selectedOptions[
//                                                             index] ==
//                                                         false) {
//                                                       selectedOptions[index] =
//                                                           null; // Change to white
//                                                     } else {
//                                                       selectedOptions[index] =
//                                                           false; // Change to red
//                                                     }
//                                                     Get.snackbar(
//                                                         'Question #${questionList[index].questionId}',
//                                                         'Question Fail ',
//                                                         colorText: Colors.white,
//                                                         backgroundColor:
//                                                             Colors.deepPurple,
//                                                         duration: const Duration(
//                                                             milliseconds: 800));
//                                                   });
//                                                 },
//                                                 iconSize,
//                                                 // "No",
//                                                 index,
//                                               ),
//                                               _buildIcon(
//                                               Icons.image,
//                                               false,
//                                               Colors.white,
//                                               _showImageSourceDialog,
//                                               iconSize,
//                                               // "Upload a Image",
//                                               index),
//                                               _buildIcon(
//                                               Icons.edit_note,
//                                               false,
//                                               Colors.white,
//                                               () => _showInputDialog(
//                                                   questionList[index]
//                                                       .questionId),
//                                               iconSize,
//                                               // "Ask a Question",
//                                               index),

//                                             ],
//                                           ),
                                       
                                          
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//             if (!isAllQuestionsDone)
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     vertical: 10.0, horizontal: 16.0),
//                 child: CustomElevatedButton(
//                   buttonText: 'Submit Checklist',
//                   buttonColor: themeController.isDarkMode.value
//                       ? AppColors.primaryColorDarker
//                       : AppColors.primaryColor,
//                   textColor: AppColors.whiteColor,
//                   onPressed: () {
//                     Get.defaultDialog(
//                       title: 'Confirm Password',
//                         content: Column(
//                       children: [
//                         TextField(
//                           controller: passwordController,
//                         ),
//                         TextButton(
//                             onPressed: () {
//                                passwordController.clear();
//                                 Navigator.pop(context);
//                               _passwordCheck(
//                                   apiToken, driverId, passwordController.text);
//                               bool areAllQuestionsAnswered = selectedOptions
//                                   .every((option) => option != null);

//                               setState(() {
//                                 isAllQuestionsDone = areAllQuestionsAnswered;
                               
//                               });
                              
//                               Get.snackbar(
//                                 'Notice',
//                                 areAllQuestionsAnswered

//                                     ? 'All questions for today are done!'
//                                     : 'Please answer all question!!',
//                                 colorText: Colors.white,
//                                 backgroundColor: Colors.deepPurple,
//                                 snackPosition: SnackPosition.BOTTOM,
//                               );
//                             },
//                             child: const Text('Confirm')),
//                       ],
//                     ),

//                     );

            
//                   },
//                 ),
//               ),
//           ],
//         )));
//   }

//   Widget _buildIcon(IconData icon, bool? isSelected, Color color,
//       VoidCallback onTap, double size,  int index) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Row(
//             children: <Widget>[
//               Icon(icon,
//                   color: isSelected == true ? color : Colors.white, size: size),
//               SizedBox(
//                 width: screenWidth * 0.05,
//               ), // Space between icon and text
//               // Text(text,
//               //     style: TextStyle(
//               //         color: isSelected == true ? color : Colors.white,
//               //         fontSize: screenWidth * 0.04)),
//             ],
//           ),
//           SizedBox(
//             height: screenHeight * 0.01,
//           )
//         ],
//       ),
//     );
//   }

//   void _showImageSourceDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Select Image Source"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(
//                     Icons.image), // Use your AppColors.primaryColor if needed
//                 title: const Text("Choose from Gallery"),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                     Icons.camera), // Use your AppColors.primaryColor if needed
//                 title: const Text("Take a Photo"),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         // Use the picked file
//         _uploadPhoto(widget.apiToken, widget.preStartId, pickedFile);
//       }
//     } catch (e) {
//       debugPrint("Image picker error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to pick image: $e'),
//         ),
//       );
//     }
//   }

//   void _showInputDialog(int questionId) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Ask a Question"),
//           content: TextField(
//             controller: questionController,
//             decoration:
//                 const InputDecoration(hintText: "Type your question here"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _submitChecklist("${widget.apiToken}", widget.preStartId,
//                     questionId, 0, questionController.text);
//                 Navigator.pop(context);
//                 setState(() {
//                   questionController.clear();
//                 });
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// // 