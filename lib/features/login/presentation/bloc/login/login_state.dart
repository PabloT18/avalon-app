part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginError extends LoginState {
  const LoginError(this.errorMessage);
  final String errorMessage;
}

class LoginMessage extends LoginState {
  const LoginMessage(this.errorMessage);
  final String errorMessage;
}

class LoginSucces extends LoginState {
  const LoginSucces(this.message);
  final String message;
}

// login_state.dart
final class LoginTwoFactorRequired extends LoginState {
  const LoginTwoFactorRequired(this.message);
  final String message;
}

final class LoginPasswordChangeRequired extends LoginState {
  const LoginPasswordChangeRequired(this.message);
  final String message;
}

final class LoginPasswordForgotRequest extends LoginState {
  const LoginPasswordForgotRequest();
}
