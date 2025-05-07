import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  const UserData({
    this.userId,
    this.fullName,
    this.email,
    this.dob,
    this.profilePicture,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final String? email;
  final String? dob;

  @JsonKey(name: 'profile_picture')
  final String? profilePicture;

  final String? token;

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserData copyWith({
    int? userId,
    String? fullName,
    String? email,
    String? dob,
    String? profilePicture,
    String? token,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      profilePicture: profilePicture ?? this.profilePicture,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    fullName,
    email,
    dob,
    profilePicture,
    token,
  ];
}
