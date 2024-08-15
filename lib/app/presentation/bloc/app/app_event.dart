part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppValidate extends AppEvent {
  const AppValidate();
}

final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;
}

final class AppGetMembresias extends AppEvent {
  const AppGetMembresias(this.user);
  final User user;
}

class AppUpdateUser extends AppEvent {
  const AppUpdateUser();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}
