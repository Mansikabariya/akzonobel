// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  userId: (json['user_id'] as num?)?.toInt(),
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  dob: json['dob'] as String?,
  profilePicture: json['profile_picture'] as String?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'user_id': instance.userId,
  'full_name': instance.fullName,
  'email': instance.email,
  'dob': instance.dob,
  'profile_picture': instance.profilePicture,
  'token': instance.token,
};
