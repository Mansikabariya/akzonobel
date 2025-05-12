import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:akzonobel/home_page/bloc/home_page_event.dart';
import 'package:akzonobel/home_page/bloc/home_page_state.dart';
import 'package:akzonobel/home_page/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<EventsEvent, EventState> {
  HomePageBloc({required this.homeRepository}) : super(EventInitial()) {
    on<FetchEvent>(eventInitialize);
  }

  final HomeRepository homeRepository;

  FutureOr<void> eventInitialize(
    FetchEvent event,
    Emitter<EventState> emit,
  ) async {
    try {
      emit(EventLoading(type: event.type));

      log('OffSet: ${event.offset}');
      log('Type: ${event.type}');
      final response = await homeRepository.getEvent(event.offset, event.type);

      if (response.isSuccessful && response.body != null && response.body['status'] == 1) {
        final dataList = response.body['data'] as List<dynamic>;

        final events = dataList.map((json) => Event.fromJson(json)).toList();

        emit(EventLoaded(events: events, type: event.type));
      } else {
        emit(
          EventError(
            errorMessage: response.body['message'],
          ),
        );
      }
    } on SocketException {
      emit(
        EventError(
          errorMessage: 'No Internet Connection. Please check your network.',
        ),
      );


    } catch (e) {}
  }
}
