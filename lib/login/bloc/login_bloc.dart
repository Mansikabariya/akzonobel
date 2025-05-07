import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:akzonobel/core/local_storage/local_storage.dart';
import 'package:akzonobel/login/login_details/login_details_response.dart';
import 'package:akzonobel/login/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginInitializeEvent>(_authInitialize);
  }

  final AuthRepository authRepository;

  FutureOr<void> _authInitialize(
      LoginInitializeEvent event,
      Emitter<LoginState> emit,
      ) async {
    try {
      emit(LoginLoading());

      final response = await authRepository.signIn(
        event.email,
        event.password,
        event.fullName,
      );

      log('Bloc Received Response Status: ${response.statusCode}');
      log('Bloc Received Response Body Raw: ${response.bodyString}');

      if (response.isSuccessful && response.body != null) {
        Map<String, dynamic> responseBodyMap;

        if (response.body is Map<String, dynamic>) {
          responseBodyMap = response.body as Map<String, dynamic>;
        } else if (response.bodyString.isNotEmpty) {
          responseBodyMap =
          jsonDecode(response.bodyString) as Map<String, dynamic>;
        } else {
          emit(LoginError(message: 'Something went wrong!'));
          return;
        }

        final loginResponse = LoginDetailsResponse.fromJson(responseBodyMap);

        if (loginResponse.status == 1) {
          // Success case
          await LocalStorage.shared.saveUserData(loginResponse.data);
          emit(
            LoginSuccess(
              successMessage: loginResponse.message,
              data: loginResponse.data,
            ),
          );
        } else if (loginResponse.status == 0 &&
            loginResponse.message.toLowerCase().contains('user record not available')) {
          // Specific case: user record not available
          emit(LoginError(message: 'User record not available.'));
        } else {
          // General fail case
          emit(LoginError(message: 'Login failed.'));
        }
      } else {
        // Generic fail case
        emit(LoginError(message: 'Login failed.'));
      }
    } catch (e, stackTrace) {
      log('Login Bloc Error: $e', error: e, stackTrace: stackTrace);
      emit(
        LoginError(
          message: 'Something went wrong! Please check your connection.',
        ),
      );
    }
  }
}
