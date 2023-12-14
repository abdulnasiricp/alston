// ignore_for_file: file_names
// // ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously, depend_on_referenced_packages, avoid_print

// import 'package:alston/api/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
// import '../utils/appcolors.dart';
// import '../utils/theme_controller.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CheckListWidget extends StatefulWidget {
//   final ThemeController themeController;
//   final String question;
//   final int questionId;
//   final Function(bool) onOptionSelected;
//   final double width; // Add a width parameter
//   const CheckListWidget({
//     Key? key,
//     required this.themeController,
//     required this.question,
//     required this.onOptionSelected,
//     this.width = 200,
//     required this.questionId, // Set a default width or you can omit it if you want
//   }) : super(key: key);

//   @override
//   _CheckListWidgetState createState() => _CheckListWidgetState();
// }

// class _CheckListWidgetState extends State<CheckListWidget> {
//   final ApiService apiService = Get.put(ApiService());
//   TextEditingController questionController= TextEditingController();

//   bool? response;

//   void _myBookingState(String apiToken, int prestartId, int questionId,
//       int flag, String note) async {
//     response = await apiService.savePrestartStep2(
//         apiToken, prestartId, questionId, flag, note);
//     print('---------response $response');
//     if (response != null) {
//       bool? bookingDetails = response;

//       print(bookingDetails);
      
//       setState(() {});
//     } else {
//       // Login failed, show an error message
//       Get.snackbar('Error', 'Api data fatch failed.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   bool isCorrectSelected = false;
//   bool isWrongSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     // Obtain screen size for responsiveness
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     // Adjust icon size and spacing based on screen size
//     double iconSize = screenWidth * 0.075; // e.g., 7.5% of screen width
//     double spaceBetween = screenHeight * 0.02; // e.g., 2% of screen height

//     return Obx(() {
//       return SizedBox(
//         width: screenWidth * 0.8,
//         height: screenHeight * 0.8,
//         child: Card(
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           color: widget.themeController.isDarkMode.value
//               ? AppColors.primaryColor
//               : AppColors.backgroundColors,
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: screenWidth * 0.1,
//               left: screenWidth * 0.03,
//               right: screenWidth * 0.02,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${widget.questionId}#.',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: screenWidth * 0.05,
//                       ).merge(GoogleFonts.josefinSans()),
//                     ),
//                     Flexible(
//                       child: Text(
//                         widget.question,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: screenWidth * 0.05,
//                         ).merge(GoogleFonts.josefinSans()),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.04),
//                 Text("Please Submit the  Following:",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: screenWidth * 0.04,
//                     )),
//                 SizedBox(height: screenHeight * 0.04),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildIcon(Icons.check, isCorrectSelected, Colors.green,
//                           () {
//                         setState(() {
//                           Get.snackbar(
//                             'Question #${widget.questionId}',
//                             'you are Passed ',
//                             colorText: Colors.white,
//                             backgroundColor: Colors.deepPurple,
//                           );

//                           isCorrectSelected = !isCorrectSelected;
//                           isWrongSelected = false;
//                           widget.onOptionSelected(isCorrectSelected);
//                         });
//                       }, iconSize, "Yes"),
//                       SizedBox(width: spaceBetween),
//                       _buildIcon(Icons.close, isWrongSelected, Colors.red, () {
//                         setState(() {
//                           Get.snackbar(
//                               'Question #${widget.questionId}', 'you are Fail ',
//                               colorText: Colors.white,
//                               backgroundColor: Colors.deepPurple,
//                               snackPosition: SnackPosition.TOP);
//                           isWrongSelected = !isWrongSelected;
//                           isCorrectSelected = false;
//                           widget.onOptionSelected(!isWrongSelected);
//                         });
//                       }, iconSize, "No"),
//                       SizedBox(width: spaceBetween),
//                       _buildIcon(Icons.image, false, Colors.white,
//                           _showImageSourceDialog, iconSize, "Upload a Image"),
//                       SizedBox(width: spaceBetween),
//                       _buildIcon(Icons.edit_note, false, Colors.white,
//                           _showInputDialog, iconSize, "Ask a Question"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildIcon(IconData icon, bool isSelected, Color color,
//       VoidCallback onTap, double size, String text) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Row(
//             children: <Widget>[
//               Icon(icon, color: isSelected ? color : Colors.white, size: size),
//               SizedBox(
//                 width: screenWidth * 0.05,
//               ), // Space between icon and text
//               Text(text,
//                   style: TextStyle(
//                       color: isSelected ? color : Colors.white,
//                       fontSize: screenWidth * 0.04)),
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
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                     Icons.camera), // Use your AppColors.primaryColor if needed
//                 title: const Text("Take a Photo"),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
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
//         // Example: setState(() => _imageFile = File(pickedFile.path));

//         // If you need to upload the image or do anything else with it,
//         // you can do that here.
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

//   void _showInputDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Ask a Question"),
//           content:  TextField(
//             controller: questionController,
//             decoration: InputDecoration(hintText: "Type your question here"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Implement logic to handle the submitted question
//                 Navigator.pop(context);
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
