part of 'sign_in_cubit.dart';

class SignInState {}

class SignInInitial extends SignInState {}
class SignInLoading extends SignInState {}
class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure(this.errMessage);
}
