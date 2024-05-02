part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}

class AppUnauthenticated extends AppState {
  const AppUnauthenticated({super.user = User.empty});
}

class AppAuthenticated extends AppState {
  const AppAuthenticated({required super.user});
}

class AppValidating extends AppState {
  const AppValidating({required super.user});
}
