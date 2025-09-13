import 'dart:async';
import 'dart:developer';

import 'package:akzonobel/core/local_storage/local_storage.dart';
import 'package:chopper/chopper.dart';

class AuthHeadersInterceptor implements Interceptor {
  const AuthHeadersInterceptor({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    final token = localStorage.getUserToken();

    // Add headers to the request
    request.headers.putIfAbsent('Accept', () => 'application/json');
    request.parameters.length;
    if (token.isNotEmpty) {
      request.headers.putIfAbsent('x-access-token', () => token);
    }


    log('REQUEST: ${request.url},\n Headers: ${request.headers}, \n Parameters: ${request.parameters}');

    // Proceed with the request chain
    final response = await chain.proceed(request);

    // Optionally, you can modify the response here
    return response;
  }
}
