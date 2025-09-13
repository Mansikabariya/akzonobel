abstract class LoginEvent {}

class LoginInitializeEvent extends LoginEvent {
  LoginInitializeEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;
}
