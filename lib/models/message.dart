import 'package:scholar_chat/constants.dart';

class Message {
  final String message;
  final String email;

  Message(this.message, this.email);

  factory Message.fromJson(json) {
    return Message(json[kMessage], json[kEmail]);
  }
}