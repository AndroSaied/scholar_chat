part of 'chat_cubit.dart';

class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Message> messages;

  ChatSuccess(this.messages);
}
