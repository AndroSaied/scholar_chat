import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/components/custom_button.dart';
import 'package:scholar_chat/components/custom_text_field.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/functions/show_snack_bar_message.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/sign_up_view.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  static String id = "Sign In View";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscure: true,
                  onChanged: (value) {
                    password = value;
                  },
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await signinWithEmailAndPassword();
                        showSnackBar(context, "Success");
                        Navigator.pushNamed(context, ChatView.id, arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, "No user found for that email.");
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              "Wrong password provided for that user.");
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
                    }
                    isLoading = false;
                    setState(() {});
                  },
                  nameButton: "Sign In",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account?  ",
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpView.id,);
                      },
                      child: const Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Color(0xffC7EDE6), fontSize: 16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinWithEmailAndPassword() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
