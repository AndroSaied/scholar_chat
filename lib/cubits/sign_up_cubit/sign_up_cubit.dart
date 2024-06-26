import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({required String email, required String password}) async {
    emit(SignUpLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure("The account already exists for that email."));
      }
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }

  }

}
