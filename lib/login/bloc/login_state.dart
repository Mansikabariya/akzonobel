import 'package:akzonobel/login/model/user_data.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.successMessage, required this.data});
  final String successMessage;
  UserData? data;
}

class LoginError extends LoginState {
  LoginError({required this.message});
  final String message;
}
