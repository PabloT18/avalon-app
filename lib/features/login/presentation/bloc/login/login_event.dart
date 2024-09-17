part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogIn extends LoginEvent {
  const LogIn();
}

class VerifyTwoFactorCode extends LoginEvent {
  final String codigo;

  const VerifyTwoFactorCode(this.codigo);

  @override
  List<Object> get props => [codigo];
}

class ChangePasswordEvent extends LoginEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordEvent(this.currentPassword, this.newPassword);

  @override
  List<Object> get props => [currentPassword, newPassword];
}
