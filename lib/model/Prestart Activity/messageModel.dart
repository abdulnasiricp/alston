// ignore_for_file: file_names

class Message{
  final String userName;
  final String text;
  final DateTime date;
  final bool isSendByMe;
  

  const Message({
    required this.userName,
    required this.text,
    required this.date,
    required this.isSendByMe
});

}