part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState({required this.title});

  final String title;

  @override
  List<Object> get props => [];
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
  const NotificationsAuthorized() : super(title: 'AUTORIZADO');
}
