part of 'push_notifications_use_cases.dart';

class SubscribeTopicsUseCase {
  const SubscribeTopicsUseCase(this._fbPushNotificationRepoImpl);
  final NotficationRepository _fbPushNotificationRepoImpl;

  Future<void> call(List<String> topics) {
    return _fbPushNotificationRepoImpl.subscribeTotopics(topics);
  }
}
