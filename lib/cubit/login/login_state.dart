part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {
  final LoginType type;

  LoginLoading(this.type);
}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

final class LoginValidationError extends LoginState {
  final String message;

  LoginValidationError(this.message);
}

enum LoginType {
  email,
  google,
}
