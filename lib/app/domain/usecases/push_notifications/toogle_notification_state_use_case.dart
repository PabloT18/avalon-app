part of 'push_notifications_use_cases.dart';

class ToggleNotificationStateUseCase {
  const ToggleNotificationStateUseCase(
      {required NotficationRepository repository})
      : _fbPushNotificationRepoImpl = repository;
  final NotficationRepository _fbPushNotificationRepoImpl;
  Future<void> call(bool request) =>
      _fbPushNotificationRepoImpl.toogleStatus(request);
}
