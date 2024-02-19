import 'package:flutter/material.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/sign_in_view.dart';
import 'package:scholar_chat/views/sign_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignInView.id : (context) =>  SignInView(),
        SignUpView.id : (context) =>  SignUpView(),
        ChatView.id : (context) => const ChatView(),
      },

      initialRoute: SignInView.id,
    );
  }
}