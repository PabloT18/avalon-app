part of 'push_notifications_use_cases.dart';

class ToggleNotificationStateUseCase {
  const ToggleNotificationStateUseCase(
      {required NotficationRepository repository})
      : _fbPushNotificationRepoImpl = repository;
  final NotficationRepository _fbPushNotificationRepoImpl;
  Future<AuthorizationStatus> call(bool request) =>
      _fbPushNotificationRepoImpl.toogleStatus(request);
}
