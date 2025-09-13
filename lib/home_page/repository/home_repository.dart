import 'dart:developer';

import 'package:akzonobel/core/local_storage/local_storage.dart';
import 'package:akzonobel/core/service/api_service.dart';
import 'package:chopper/chopper.dart';

class HomeRepository
{
  const HomeRepository({required this.appApiService, required this.localStorage});

  final AppApiService appApiService;
  final LocalStorage localStorage;

  Future<Response> getEvent(String offSet, String type) async
  {
    final response = await appApiService.getEvents(offset: offSet, type: type);

    log('Response: $response');
    log('status code: ${response.statusCode}');
    return response;
  }
}