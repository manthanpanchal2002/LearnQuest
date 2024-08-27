import 'package:learn_quest/dataModels/coursesModel.dart';

// =================================================== sign-up ===================================================
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;
  final String msg;

  SignUpFailure(this.error, this.msg);
}

// =================================================== login ===================================================
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  // get token
  // final String? token;
  // LoginSuccess(this.token);
}

class LoginFailure extends LoginState {
  final String error;
  final String msg;

  LoginFailure(this.error, this.msg);
}

// =================================================== Fetch courses ===================================================
abstract class CoursesState {}

class InitialState extends CoursesState {}

class LoadingState extends CoursesState {}

class SuccessState extends CoursesState {
  final List<CoursesModel> courses;
  SuccessState(this.courses);
}

class ErrorState extends CoursesState {
  final String error;
  final String msg;
  ErrorState(this.error, this.msg);
}
