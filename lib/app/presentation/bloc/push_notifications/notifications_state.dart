part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState({required this.title});

  final String title;

  @override
  List<Object?> get props => [];
}

/// Estado de notificaiones en la aplicacion NO DETERMINADO
final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial() : super(title: 'NO DETERMINADO');
}

/// Estado de notificaiones en la aplicacion DENEGADO
final class NotificationsDenied extends NotificationsState {
  const NotificationsDenied() : super(title: 'DENEGADO');
}

/// Estado de notificaiones en la aplicacion AUTORIZADO
final class NotificationsAuthorized extends NotificationsState {
  const NotificationsAuthorized({
    required this.userActiveNotifiaction,
    this.subscripcionresError,
    this.subscripcionTopicMessage,
    this.deactivateError,
  }) : super(title: 'AUTORIZADO');

  final String? subscripcionresError;
  final String? subscripcionTopicMessage;
  final String? deactivateError;
  final bool userActiveNotifiaction;

  NotificationsAuthorized copyWiht({
    required bool userActiveNotifiaction,
    String? subscripcionresError,
    String? subscripcionTopicMessage,
    String? deactivateError,
  }) =>
      NotificationsAuthorized(
        userActiveNotifiaction: userActiveNotifiaction,
        subscripcionresError: subscripcionresError ?? this.subscripcionresError,
        subscripcionTopicMessage:
            subscripcionTopicMessage ?? this.subscripcionTopicMessage,
        deactivateError: deactivateError,
      );

  @override
  List<Object?> get props => [
        userActiveNotifiaction,
        subscripcionresError,
        subscripcionTopicMessage,
        deactivateError,
      ];
}
