part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class InitiNotifications extends NotificationsEvent {
  const InitiNotifications();
}

class SubscribeTopics extends NotificationsEvent {
  const SubscribeTopics(this.tipics);

  final List<String> tipics;
}

class _NotificationSetStatus extends NotificationsEvent {
  const _NotificationSetStatus(this.status);

  final AuthorizationStatus status;
}

// class NotificationToogleStatus extends NotificationSetStatus {
//   const NotificationToogleStatus(bool auth)
//       : super(
//             auth ? AuthorizationStatus.authorized : AuthorizationStatus.denied);
// }

class NotificationToggleStatus extends NotificationsEvent {
  const NotificationToggleStatus();
}

class NotificationDellFCM extends NotificationsEvent {
  const NotificationDellFCM();
}
