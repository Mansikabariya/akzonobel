import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String correctEmail = "mansi@gmail.com";
  final String correctPassword = "123456";

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      await Future.delayed(Duration(seconds: 1));

      if (event.email == correctEmail && event.password == correctPassword) {
        emit(LoginSuccess('Login Successful'));
      } else {
        emit(LoginError('Invalid email or password'));
      }
    });
  }
}
