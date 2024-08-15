import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../../../../features/membresias/membresias.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
      {required AuthenticationRepository authenticationRepository,
      required GetMembresiasUC getMembresias})
      : _authenticationRepository = authenticationRepository,
        _getMembresias = getMembresias,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppAuthenticated(user: authenticationRepository.currentUser)
              : const AppUnauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppValidate>(_onAppValidate);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppGetMembresias>(_onAppGetMembresias);
    _userSubscription = _authenticationRepository.status.listen(
      (user) => add(_AppUserChanged(user)),
    );

    validateFirst = false;
  }

  final GetMembresiasUC _getMembresias;

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  late bool validateFirst;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    if (event.user.isNotEmpty) {
      add(AppGetMembresias(event.user));
      // emit(AppAuthenticated(user: event.user));
    } else {
      // emit(const AppValidating(user: User.empty));

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

  FutureOr<void> _onAppGetMembresias(
      AppGetMembresias event, Emitter<AppState> emit) async {
    if (state is! AppAuthenticated && event.user.isEmpty) {
      return;
    }

    final currentState = state as AppAuthenticated;
    try {
      final result =
          await _getMembresias(event.user.id.toString(), event.user.token!);
      emit(currentState.copyWith(membresias: result));
    } catch (e) {
      emit(currentState.copyWith(membresias: []));
    }
  }
}
