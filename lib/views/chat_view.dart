import "package:flutter/material.dart";
import "package:scholar_chat/constants.dart";
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
  CollectionReference messages = FirebaseFirestore.instance.collection(kCollictionMessages);
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    var email = ModalRoute.of(context)!.settings.arguments;
    
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(), 
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          List<Message> messagesList = [];
          for(int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          
          return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50,),
            const Text("Chat", style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _controller,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                return messagesList[index].email == email ? ChatBubble(message: messagesList[index],) : ChatBubbleForFriend(message: messagesList[index]);
              },),
          ),
          Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {
            messages.add({
              kMessage : value,
              kCreatedAt : DateTime.now(),
              kEmail : email
            });
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
        } else {
          return const Text("Loading...");
        }
      },);
  } 
}