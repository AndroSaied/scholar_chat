import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/models/message.dart';


import '../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(kCollictionMessages);
  List<Message> messagesList = [];

  sendMessage({required String message, required var email}) {

    messages.add({
      kMessage : message,
      kCreatedAt : DateTime.now(),
      kEmail : email,
    });

  }

  getMessages() {

    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for(var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messagesList));
    },);

  }

}
