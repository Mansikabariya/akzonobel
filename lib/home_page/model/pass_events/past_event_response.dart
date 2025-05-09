import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'event_data.dart';

part 'past_event_response.g.dart';

@JsonSerializable()
class PastEventResponse extends Equatable {
  const PastEventResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PastEventResponse.fromJson(Map<String, dynamic> json) =>
      _$PastEventResponseFromJson(json);

  final int? status;
  final String? message;
  final List<EventData>? data;

  Map<String, dynamic> toJson() => _$PastEventResponseToJson(this);

  @override
  List<Object?> get props => [status, message, data];
}
