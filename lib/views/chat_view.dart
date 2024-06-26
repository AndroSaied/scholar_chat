import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scholar_chat/constants.dart";
import "package:scholar_chat/cubits/chat_cubit/chat_cubit.dart";
import "package:scholar_chat/functions/chat_bubbles.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:scholar_chat/models/message.dart";

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  static String id = "Chat View";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              "Chat",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
  builder: (context, state) {
    List<Message> messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
    return ListView.builder(
              reverse: true,
              controller: _controller,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                return messagesList[index].email == email
                    ? ChatBubble(
                        message: messagesList[index],
                      )
                    : ChatBubbleForFriend(message: messagesList[index]);
              },
            );
  },
),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: value, email: email);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceIn,
                );
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.send),
                suffixIconColor: kPrimaryColor,
                hintText: "Send Message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    width: 2,
                    color: kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    width: 2,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
