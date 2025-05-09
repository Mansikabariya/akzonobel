// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PastEventResponse _$PastEventResponseFromJson(Map<String, dynamic> json) =>
    PastEventResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => EventData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PastEventResponseToJson(PastEventResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
