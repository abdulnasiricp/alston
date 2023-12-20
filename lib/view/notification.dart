// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, depend_on_referenced_packages, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/Prestart%20Activity/messageModel.dart';
import '../utils/appcolors.dart';
import '../utils/theme_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();
  late WebSocketChannel channel;
  List<Message> messages = [
    Message(
      userName: 'admin',
      text: 'Yes sure',
      date: DateTime.now(),
      isSendByMe: false,
    ),
  ].reversed.toList();

  late int? driverId = 0;
  late int? vehicleId;
  late String apiToken = '';
  late String DriverName = '';
  LoadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    driverId = sp.getInt('driverId');
    vehicleId = sp.getInt('vehicleId');
    apiToken = sp.getString('apiToken') ?? "";
    DriverName = sp.getString('userName') ?? "";

    setState(() {});
  }

  getData() async {
    await LoadData();
  }

  @override
  void initState() {
    super.initState();
    getData();
    // Connect to the WebSocket server
    channel = IOWebSocketChannel.connect(
      'ws://cloudfront.safelineworld.com:6001/app/safeline',
    );

 
  // Listen for incoming messages
  channel.stream.listen((message) {
    // Handle the received message
    handleMessage(message);
  });
}

  void handleMessage(String message) {
  // Parse the received message
  Map<String, dynamic> jsonMessage = jsonDecode(message);

  // Check the message key
  String key = jsonMessage['key'];

  // Handle the message based on its key
  switch (key) {
    case 'SendMessage':
      // Handle SendMessage response if needed
      break;
    case 'GetMessageNotification':
      // Handle GetMessageNotification
      handleReceivedMessage(jsonMessage['body']);
      break;
    default:
      // Handle other message keys if needed
      break;
  }
}

void handleReceivedMessage(Map<String, dynamic> body) {
  // Extract the data list from the body
  List<dynamic> dataList = body['data'];

  // Iterate through each message in the data list
  for (var messageData in dataList) {
    // Extract information from the message data
    int msgId = messageData['msg_id'];
    String receivedMessage = messageData['message'];
    String sentBy = messageData['sent_by'];
    int isAck = messageData['is_ack'];
    String dateTimeString = messageData['date_time'];

    // Parse the date time string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Create a Message object with the extracted information
    final receivedMessageObj = Message(
      userName: sentBy,
      text: receivedMessage,
      date: dateTime,
      isSendByMe: false,
    );

    // Update the UI with the received message
    setState(() {
      messages.add(receivedMessageObj);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Administrator',
              style: GoogleFonts.lato(),
            ),
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
                  themeController
                      .toggleTheme(!themeController.isDarkMode.value);
                },
              ),
            ],
          ),
          body: Container(
            color: themeController.isDarkMode.value
                ? AppColors.backgroundColorDarker
                : AppColors.backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: AppColors.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    elements: [...messages],
                    groupBy: (message) => DateTime(
                      message.date.year,
                      message.date.month,
                      message.date.day,
                    ),
                    itemBuilder: (context, Message message) => Align(
                      alignment: message.isSendByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        color: message.isSendByMe
                            ? AppColors.primaryColor
                            : Colors.grey.shade600,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.userName,
                                style: const TextStyle(
                                  color: AppColors.messageColor,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.josefinSans()),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message.text,
                                style: TextStyle(
                                  color: message.isSendByMe
                                      ? AppColors.messageColor
                                      : AppColors.messageColor,
                                ).merge(GoogleFonts.josefinSans()),
                              ),
                              Text(
                                DateFormat.yMMMd().format(message.date),
                                style: const TextStyle(
                                  color: AppColors.messageColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: themeController.isDarkMode.value
                      ? Colors.grey.shade500
                      : Colors.grey.shade300,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 70,
                        child: TextField(
                          style: GoogleFonts.josefinSans(),
                          controller: messageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'Type your message here...',
                          ),
                          onSubmitted: (text) {
                            sendMessage(text);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            sendMessage(messageController.text);
                          },
                          icon: const Icon(Icons.send),
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void sendMessage(String text) {
    // Replace with the actual driver ID
    driverId = driverId;

    // Create a JSON message with the specified structure for sending a chat message
    final jsonMessage = {
      "key": "SendMessage",
      "body": {
        "driver_id": driverId,
        "message": text,
      },
    };

    // Convert the JSON message to a string and send it to the server
    channel.sink.add(jsonEncode(jsonMessage));

    // Update the UI with the sent message
    final message = Message(
      userName: DriverName,
      text: text,
      date: DateTime.now(),
      isSendByMe: true,
    );
    setState(() {
      messages.add(message);
      messageController.text = '';
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

