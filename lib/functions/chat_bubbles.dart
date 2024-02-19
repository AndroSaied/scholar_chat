import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
            ),
            child: Text(
              message.message,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
          ),
        );
      }
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key, required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            decoration: const BoxDecoration(
              color: Color(0xff006389),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
            ),
            child: Text(
              message.message,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
          ),
        );
      }
    );
  }
}