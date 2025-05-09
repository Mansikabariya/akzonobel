// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDetailsResponse _$LoginDetailsResponseFromJson(
  Map<String, dynamic> json,
) => LoginDetailsResponse(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data:
      json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginDetailsResponseToJson(
  LoginDetailsResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
