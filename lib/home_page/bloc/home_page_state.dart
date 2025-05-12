import 'package:equatable/equatable.dart';

import 'home_page_event.dart';

class EventState extends Equatable
{
  const EventState();
  @override
  List<Object?> get props => [];
}


class EventInitial extends EventState {}

class EventLoading extends EventState{
  const EventLoading({required this.type});
  final String type;
}

class EventLoaded extends EventState {
  const EventLoaded({required this.events, required this.type});

  final List<Event> events;
  final String type;

  @override
  List<Object?> get props => [events, type];
}

class EventError extends EventState {
  const EventError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

