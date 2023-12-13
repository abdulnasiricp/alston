// ignore_for_file: depend_on_referenced_packages

import 'package:alston/model/Prestart%20Activity/messageModel.dart';
import 'package:alston/utils/appcolors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import '../utils/theme_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();
  List<Message> messages = [
    Message(
        text: 'Yes sure',
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
        isSendByMe: false),
  ].reversed.toList();

  @override
  Widget build(BuildContext context ) {
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
              themeController.toggleTheme(!themeController.isDarkMode.value);
            },
          ),
        ],
      ),


        body:Container(
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
                                  style: const TextStyle(color: Colors.white),
                                  DateFormat.yMMMd().format(message.date)),
                            ),
                          ),
                        ),
                      ),
                      elements: messages,
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
                              : Colors.grey.shade300,
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(message.text,
                                style: TextStyle(
                                    color: message.isSendByMe
                                        ? AppColors.messageColor
                                        : AppColors.messageColor).merge(GoogleFonts.josefinSans())),
                          ),
                        ),
                      ))),
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
                            hintText: 'Type your message here...'),
                        onSubmitted: (text) {
                          final message = Message(
                              text: text, date: DateTime.now(), isSendByMe: true);
                          setState(() {
                            messages.add(message);
                            messageController.text = '';
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          final message = Message(
                              text: messageController.text,
                              date: DateTime.now(),
                              isSendByMe: true);
                          setState(() {
                            messages.add(message);
                            messageController.text = '';
                          });
                        },
                        icon: const Icon(Icons.send),
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    ));
  }
}
