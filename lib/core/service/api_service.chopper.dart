// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AppApiService extends AppApiService {
  _$AppApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AppApiService;

  @override
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
    required String fullName,
  }) {
    final Uri $url = Uri.parse('account/user_Login');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = <String, String>{
      'email': email.toString(),
      'password': password.toString(),
      'full_name': fullName.toString(),
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
