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
          // authenticationRepository.currentUser.isNotEmpty
          //     ? AppAuthenticated(user: authenticationRepository.currentUser)
          //     : const AppUnauthenticated(),
          const AppValidating(user: User.empty),
        ) {
    on<AppValidate>(_onAppValidate);
    on<AppUpdateUser>(_onUpdateUser);
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppGetMembresias>(_onAppGetMembresias);

    _userSubscription = _authenticationRepository.status.listen((user) {
      add(_AppUserChanged(user));
    });
  }

  final GetMembresiasUC _getMembresias;

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    if (event.user.isNotEmpty) {
      if (state is AppAuthenticated) {
        emit((state as AppAuthenticated).copyWith(user: event.user));
      } else {
        emit(AppAuthenticated(user: event.user));
      }
      if (event.user.rol != null && event.user.userRol == UserRol.client) {
        add(AppGetMembresias(event.user));
      }
    } else {
      // emit(const AppValidating(user: User.empty));
      // _authenticationRepository.logOut();
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
    final validatedUser = await _authenticationRepository.validateAccount();
    add(_AppUserChanged(validatedUser));
  }

  FutureOr<void> _onAppGetMembresias(
      AppGetMembresias event, Emitter<AppState> emit) async {
    if (state is! AppAuthenticated && event.user.isEmpty) {
      return;
    }

    final currentState = state as AppAuthenticated;
    try {
      final result = await _getMembresias.call(
          event.user.id.toString(), event.user.token!);
      emit(currentState.copyWith(membresias: result));
    } catch (e) {
      emit(currentState.copyWith(membresias: []));
    }
  }

  FutureOr<void> _onUpdateUser(
      AppUpdateUser event, Emitter<AppState> emit) async {
    final validatedUser = await _authenticationRepository.validateAccount();
    emit((state as AppAuthenticated).copyWith(user: validatedUser));
  }
}
