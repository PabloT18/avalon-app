import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
export 'package:authentication_repository/authentication_repository.dart'
    show User;

import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              // ? AppState.authenticated(authenticationRepository.currentUser)
              // : const AppState.unauthenticated(),
              ? AppAuthenticated(user: authenticationRepository.currentUser)
              : const AppUnauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppValidate>(_onAppValidate);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );

    validateFirst = false;
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  late bool validateFirst;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    if (event.user.isNotEmpty) {
      emit(AppAuthenticated(user: event.user));
    } else {
      emit(const AppValidating(user: User.empty));

      emit(const AppUnauthenticated(user: User.empty));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onAppValidate(
      AppValidate event, Emitter<AppState> emit) async {
    if (validateFirst) {
      _authenticationRepository.logOut();
      final validatedUser = await _authenticationRepository.validateAccount();
      add(_AppUserChanged(validatedUser));
    }
    validateFirst = true;
  }
}
