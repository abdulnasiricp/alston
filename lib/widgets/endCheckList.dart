// ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_string_interpolations, unused_element, use_build_context_synchronously, file_names, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'package:alston/model/ConfirmPassword_model.dart';
import 'package:alston/model/EndShift/endShiftQuestion_model.dart';
import 'package:alston/model/EndShift/endShiftSubmitQuestion_model.dart';
import 'package:alston/model/EndShift/endShiftUploadPhoto_model.dart';
import 'package:alston/view/shiftscreen.dart';
import 'package:http/http.dart' as http;

import 'package:alston/api/api_service.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:alston/widgets/customelevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alston/utils/theme_controller.dart';
import 'package:http_parser/http_parser.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndCheckList extends StatefulWidget {
  final String apiToken;
  final int eosId;
  const EndCheckList({Key? key, required this.apiToken, required this.eosId})
      : super(key: key);

  @override
  State<EndCheckList> createState() => _EndCheckListState();
}

class _EndCheckListState extends State<EndCheckList> {
  final ApiService apiService = Get.put(ApiService());

  late int? driverId;
  late int? vehicleId;
  late String apiToken = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId');
    vehicleId = sp.getInt('vehicleId');
    apiToken = sp.getString('apiToken') ?? "";
    print(driverId);
    print(vehicleId);
    print(apiToken);
    setState(() {});
  }

  getData() async {
    await LoadData();
  }

  EndShiftQuestion? response;
  List<Questions> questionList = [];

  Future<void> _questionList(String apiToken) async {
    response = await apiService.endShiftVehicleAndQuestions(apiToken);
    print('---------response $response');
    if (response != null && response?.success == 1) {
      questionList = response!.data.questions;

      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fetch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  ConfirmPassword? passwordResponse;

  void _passwordCheck(String? apiToken, int? driverId, String? password) async {
    passwordResponse =
        await apiService.checkPassword(apiToken, driverId, password);
    print('---------response $passwordResponse');
    if (passwordResponse != null) {
      print('----------$passwordResponse');
      ConfirmPassword? bookingDetails = passwordResponse;

      print(bookingDetails?.message);
      // Get.snackbar('Notice', '${bookingDetails?.message}',
      //     backgroundColor: Colors.deepPurple,
      //     colorText: Colors.white,
      //     snackPosition: SnackPosition.TOP);
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fetch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isCorrectSelected = false;
  bool isWrongSelected = false;
  bool onOptionSelected = false;

//*******************************
  EndShiftQuestionSubmit? submitResponse;

  void _submitEndChecklist(String? apiToken, int? eosId, int? questionId,
      int? flag, String? note) async {
    submitResponse = await apiService.saveEndshiftStep2(
        apiToken, eosId, questionId, flag, note);
    print('---------response $submitResponse');
    if (submitResponse != null) {
      print('----------$submitResponse');
      EndShiftQuestionSubmit? bookingDetails = submitResponse;

      print(bookingDetails?.message);
      Get.snackbar('', '${bookingDetails?.message}',
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      setState(() {});
    } else {
      // Login failed, show an error message
      Get.snackbar('Error', 'Api data fetch failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //*********************************
  EndShiftUploadPhoto? uploadphotoResponse;
  final String _baseUrl = 'https://cloudfront.safelineworld.com/api';

  void _uploadPhoto(String apiToken, int eosId, XFile photoFile) async {
    var url = Uri.parse('$_baseUrl/submit-eos-photo');

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll({
          'api_token': apiToken,
          'eos_id': eosId.toString(),
        })
        ..files.add(await http.MultipartFile.fromPath(
          'photo',
          photoFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successful upload
        var jsonResponse = json.decode(await response.stream.bytesToString());
        EndShiftUploadPhoto uploadPhoto =
            EndShiftUploadPhoto.fromJson(jsonResponse);

        // Handle the response as needed
        print('Upload Success: ${uploadPhoto.message}');
        Get.snackbar('', '${uploadPhoto.message}',
            backgroundColor: Colors.deepPurple,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      } else {
        // Handle non-200 response
        print('Upload Error: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to upload photo',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Handle network or other errors
      print('Exception caught: $e');
      Get.snackbar('Error', 'Failed to upload photo',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _questionList('${widget.apiToken}').then((_) {
      // Initialize selectedOptions list with false
      selectedOptions = List.generate(questionList.length, (index) => null);
    });
  }

  List<bool?> selectedOptions = [];

  late bool isAllQuestionsDone = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust icon size and spacing based on screen size
    double iconSize = screenWidth * 0.075; // e.g., 7.5% of screen width
    double spaceBetween = screenHeight * 0.02; //
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('EOS Checklist', style: GoogleFonts.lato()),
          backgroundColor: themeController.isDarkMode.value
              ? AppColors.primaryColor
              : AppColors.backgroundColors,
          actions: [
            IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode // Icon for light mode
                    : Icons.dark_mode, // Icon for dark mode
                color: themeController.isDarkMode.value
                    ? AppColors.darkModeIcon
                    : AppColors.primaryColor, // Icon color in light mode
              ),
              onPressed: () {
                // Toggle the theme
                themeController.toggleTheme(!themeController.isDarkMode.value);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: isAllQuestionsDone
                  ? Center(
                      child: Row(
                        children: [
                          Text(
                            'End-Checklist Completed Today',
                            style: TextStyle(
                              color: Colors.green, // Change color as needed
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                          // const Card(
                          //     color: Colors.green,
                          //     child: Icon(
                          //       Icons.check,
                          //       color: Colors.white,
                          //       size: 25,
                          //     ))
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: questionList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 10),
                          child: SizedBox(
                            // width: screenWidth * 0.8,
                            child: Card(
                              // elevation: 4,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: themeController.isDarkMode.value
                                  ? AppColors.primaryColor
                                  : AppColors.backgroundColors,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: screenWidth * 0.01,
                                  left: screenWidth * 0.03,
                                  right: screenWidth * 0.02,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '# ${questionList[index].questionId} : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.05,
                                          ).merge(GoogleFonts.josefinSans()),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${questionList[index].question}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.05,
                                            ).merge(GoogleFonts.josefinSans()),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _buildIcon(
                                              Icons.check,
                                              selectedOptions[index] == true,
                                              Colors.greenAccent[700]!,
                                              () {
                                                setState(() {
                                                  if (selectedOptions[index] ==
                                                      true) {
                                                    selectedOptions[index] =
                                                        null; // Change to white
                                                  } else {
                                                    selectedOptions[index] =
                                                        true; // Change to green
                                                  }
                                                  Get.snackbar(
                                                      'Question #${questionList[index].questionId}',
                                                      'Question Pass ',
                                                      colorText: Colors.white,
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      duration: const Duration(
                                                          milliseconds: 800));
                                                });
                                              },
                                              35,
                                              // "Yes",
                                              index,
                                            ),
                                            _buildIcon(
                                              Icons.close,
                                              selectedOptions[index] == false,
                                              Colors.red,
                                              () {
                                                setState(() {
                                                  if (selectedOptions[index] ==
                                                      false) {
                                                    selectedOptions[index] =
                                                        null; // Change to white
                                                  } else {
                                                    selectedOptions[index] =
                                                        false; // Change to red
                                                  }
                                                  Get.snackbar(
                                                      'Question #${questionList[index].questionId}',
                                                      'Question Fail ',
                                                      colorText: Colors.white,
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      duration: const Duration(
                                                          milliseconds: 800));
                                                });
                                              },
                                              35,
                                              // "No",
                                              index,
                                            ),
                                            _buildIcon(
                                                Icons.camera,
                                                false,
                                                Colors.white,
                                                _showImageSourceDialog,
                                                35,
                                                // "Upload a Image",
                                                index),
                                            _buildIcon(
                                                Icons.edit,
                                                false,
                                                Colors.white,
                                                () => _showInputDialog(
                                                    questionList[index]
                                                        .questionId),
                                                35,
                                                // "Ask a Question",
                                                index),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (!isAllQuestionsDone)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                child: CustomElevatedButton(
                  buttonText: 'Submit Checklist',
                  buttonColor: themeController.isDarkMode.value
                      ? AppColors.primaryColorDarker
                      : AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Confirm Password',
                      titleStyle:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.only(top: 30, bottom: 30),
                      content: Column(
                        children: [
                          TextField(
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                passwordController.clear();
                                Navigator.pop(context);
                                _passwordCheck(apiToken, driverId,
                                    '${passwordController.text}');
                                bool areAllQuestionsAnswered = selectedOptions
                                    .every((option) => option != null);

                                setState(() {
                                  isAllQuestionsDone = areAllQuestionsAnswered;
                                  if (isAllQuestionsDone) {
                                    Get.to(() => const ShiftScreen());
                                  }
                                });

                                Get.snackbar(
                                  'Notice',
                                  areAllQuestionsAnswered
                                      ? 'All questions for today are done!'
                                      : 'Please answer all question!!',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        )));
  }

  Widget _buildIcon(IconData icon, bool? isSelected, Color color,
      VoidCallback onTap, double size, int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all()
                  ),
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(1),
                  child: Icon(icon,
                      color: isSelected == true ? color : Colors.white,
                      size: size),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          )
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                    Icons.image), // Use your AppColors.primaryColor if needed
                title: const Text("Choose from Gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                    Icons.camera), // Use your AppColors.primaryColor if needed
                title: const Text("Take a Photo"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        // Use the picked file
        _uploadPhoto(widget.apiToken, widget.eosId, pickedFile);
      }
    } catch (e) {
      debugPrint("Image picker error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
        ),
      );
    }
  }

  void _showInputDialog(int questionId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text("Note",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          content: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Adjust padding here
            child: TextField(
              controller: questionController,
              decoration: const InputDecoration(
                hintText: "Type your question here",
                hintStyle: TextStyle(fontSize: 20),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 30, bottom: 30),
          actions: [
            TextButton(
              onPressed: () {
                _submitEndChecklist("${widget.apiToken}", widget.eosId,
                    questionId, 0, questionController.text);
                Navigator.pop(context);
                setState(() {
                  questionController.clear();
                });
              },
              child: const Center(
                  child: Text("Submit", style: TextStyle(fontSize: 18))),
            ),
          ],
        );
      },
    );
  }
}
