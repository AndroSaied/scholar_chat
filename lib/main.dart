import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:scholar_chat/cubits/sign_up_cubit/sign_up_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          SignInView.id : (context) =>  const SignInView(),
          SignUpView.id : (context) =>  const SignUpView(),
          ChatView.id : (context) => const ChatView(),
        },

        initialRoute: SignInView.id,
      ),
    );
  }
}