
import 'package:akzonobel/login/model/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_details_response.g.dart';

@JsonSerializable()
class LoginDetailsResponse extends Equatable {
  const LoginDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDetailsResponseFromJson(json);

  final int status;
  final String message;
  final UserData? data;

  Map<String, dynamic> toJson() => _$LoginDetailsResponseToJson(this);

  LoginDetailsResponse copyWith({
    int? status,
    String? message,
    UserData? data,
  }) {
    return LoginDetailsResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
