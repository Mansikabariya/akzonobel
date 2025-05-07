import 'dart:developer';

import 'package:akzonobel/core/local_storage/local_storage.dart';
import 'package:akzonobel/core/service/api_service.dart';
import 'package:akzonobel/login/login_details/login_details_response.dart';
import 'package:chopper/chopper.dart';

class AuthRepository {
  AuthRepository({required this.appApiService, required this.localStorage});

  final AppApiService appApiService;
  final LocalStorage localStorage;

  Future<Response> signIn(
      String email,
      String password,
      String fullName,
      ) async {
    final response = await appApiService.signIn(
      email: email,
      password: password,
      fullName: fullName, // Ensure your AppApiService.signIn includes this @Field if needed by the API
    );

    log('SignIn Response Status Code: ${response.statusCode}');
    log('SignIn Response Body: ${response.bodyString}'); // Log raw string for debugging
    log('SignIn Response Error: ${response.error}');

    // The type <LoginDetailsResponse> depends on the Chopper converter
    // successfully parsing the *response* body.
    // Robust handling should occur in the BLoC.
    return response;
  }
}