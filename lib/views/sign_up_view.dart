import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/components/custom_button.dart';
import 'package:scholar_chat/components/custom_text_field.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:scholar_chat/functions/show_snack_bar_message.dart';
import 'package:scholar_chat/views/chat_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static String id = "Sign Up View";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          showSnackBar(context, "Success");
          Navigator.pushNamed(context, ChatView.id, arguments: email);
          isLoading = false;
        } else if (state is SignUpFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/scholar.png",
                      height: 100,
                    ),
                    const Text(
                      "Scholar Chat",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Pacifico",
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 85,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      obscure: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpCubit>(context).signUp(email: email!, password: password!);
                        }

                      },
                      nameButton: "Sign Up",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sign In",
                            style:
                            TextStyle(color: Color(0xffC7EDE6), fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
