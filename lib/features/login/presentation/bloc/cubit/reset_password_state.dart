part of 'reset_password_cubit.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState({this.isLoading = false, this.error});

  final bool isLoading;
  final String? error;

  @override
  List<Object> get props => [isLoading];
}

final class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial({super.isLoading, super.error});
  @override
  List<Object> get props => [isLoading];
}

final class ResetPasswordDataReques extends ResetPasswordState {
  const ResetPasswordDataReques({super.isLoading, super.error});

  @override
  List<Object> get props => [isLoading];
}

final class ResetPasswordsucces extends ResetPasswordState {
  const ResetPasswordsucces();
}
