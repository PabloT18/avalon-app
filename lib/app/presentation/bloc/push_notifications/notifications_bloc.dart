import 'dart:async';
import 'dart:convert';

import 'dart:developer';

import 'package:avalon_app/app/data/sources/local_notifications.dart';
import 'package:avalon_app/app/domain/repository/notification_repository.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    show AuthorizationStatus;

import '../../../data/sources/remoteFB/puhs_notifications_fb.dart';
import '../../../domain/entity/push_notifications/push_message.dart';
import '../../../domain/usecases/push_notifications/push_notifications_use_cases.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required GetStatusCheckUseCase getStatusCheckUseCase,
    required ToggleNotificationStateUseCase toogleNotificationStateUC,
    required SubscribeTopicsUseCase subscribeTopicsUseCase,
    required this.notificationRepository,
  })  : _getStatusCheckUC = getStatusCheckUseCase,
        _toogleNotificationStateUC = toogleNotificationStateUC,
        _subscribeTopicsUseCase = subscribeTopicsUseCase,
        super(const NotificationsInitial()) {
    on<InitiNotifications>(_onInitiNotificationson);
    on<_NotificationSetStatus>(_onNotificationSetStatus);
    on<NotificationToggleStatus>(_onNotificationTooglePermision);
    on<SubscribeTopics>(_onSubscribeTopics);
    on<NotificationDellFCM>(_onNotificationDellFCM);
    // Verificar estado de las notificaciones
    // _initialStatusCheck();
    _localNotificationCount = 0;
  }

  final GetStatusCheckUseCase _getStatusCheckUC;
  final ToggleNotificationStateUseCase _toogleNotificationStateUC;
  final SubscribeTopicsUseCase _subscribeTopicsUseCase;

  late int _localNotificationCount;

  final NotficationRepository notificationRepository;

  /// Metodo inicial que validad el estado de las notificaiones y emite un
  /// state segun los permisno de las notificaiones que tenga el telefono.
  /// Si no esta determinado internamente el repositortio pide permisos.
  // void _initialStatusCheck() async {

  /// Manejo los tipos de notifcaciones
  /// 1 - Flutter LocalNotifications - Local
  /// 2 - FIrebaseCloudMessgain - Remote
  FutureOr<void> _onInitiNotificationson(
      InitiNotifications event, Emitter<NotificationsState> emit) async {
    final authorizationStatus = await _getStatusCheckUC.call();
    add(_NotificationSetStatus(authorizationStatus));

    /// Listener para notificaiones en Foreground sin importat el estado de
    /// autorizacion de perimisos para las notificacioenes (Objeto estatico)
    PushNotificationSourceFCM.messagesStream.listen((message) {
      switch (message.notificationMessageType) {
        case NotificationMessageType.onOpenApp:
          log("NotificationsBloc -> NotificationMessageType.onOpenApp");
          LocalNotifications.showLocalNotification(++_localNotificationCount,
              message.title, message.body, json.encode(message.data));
          break;
        case NotificationMessageType.onSuspendApp:
          if (message.hasRoute) {
            AppRouter.navigateFromPushMessage(message);
          }
          break;

        case NotificationMessageType.onTerminateApp:
          break;
        default:
      }
    });
  }

  /// Emitir un estado segun el cambion a la autorizacion de un usario par las
  /// notificaciones
  FutureOr<void> _onNotificationSetStatus(
      _NotificationSetStatus event, Emitter<NotificationsState> emit) async {
    switch (event.status) {
      case AuthorizationStatus.authorized:
        final getUserActiveNotification =
            await notificationRepository.getUserActiveNotification();
        if (getUserActiveNotification == null || getUserActiveNotification) {
          add(const SubscribeTopics(['todos', 'PTorres']));
          emit(const NotificationsAuthorized(userActiveNotifiaction: true));
        } else {
          emit(const NotificationsAuthorized(userActiveNotifiaction: false));
        }
        // emit(const NotificationsAuthorized());
        break;
      case AuthorizationStatus.denied:
        emit(const NotificationsDenied());
        break;
      default:
        emit(const NotificationsInitial());
    }
  }

  FutureOr<void> _onNotificationTooglePermision(
      NotificationToggleStatus event, Emitter<NotificationsState> emit) async {
    final request = state is! NotificationsAuthorized;
    if (request) {
      final authorizationStatus =
          await notificationRepository.requestPermission();
      add(_NotificationSetStatus(authorizationStatus));
    } else {
      final getUserActiveNotification =
          await notificationRepository.getUserActiveNotification();

      final newState =
          getUserActiveNotification == null ? true : !getUserActiveNotification;
      final repsonse = await notificationRepository.toogleStatus(newState);
      emit((state as NotificationsAuthorized)
          .copyWiht(userActiveNotifiaction: repsonse));
    }
  }

  FutureOr<void> _onSubscribeTopics(
      SubscribeTopics event, Emitter<NotificationsState> emit) async {
    await _subscribeTopicsUseCase.call(event.tipics);
  }

  FutureOr<void> _onNotificationDellFCM(
      NotificationDellFCM event, Emitter<NotificationsState> emit) async {
    try {
      await notificationRepository.dellFCM();
    } catch (e) {}
  }
}
