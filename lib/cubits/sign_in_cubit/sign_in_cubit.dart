import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());

    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccess());

    // } on FirebaseAuthException catch (e) {
    //   print("=================${e.code}");
    //   if (e.code == 'user-not-found') {
    //     emit(SignInFailure('No user found for that email.'));
    //   } else if (e.code == 'wrong-password') {
    //     emit(SignInFailure('Wrong password provided for that user.'));
    //   }
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }

  }

}
