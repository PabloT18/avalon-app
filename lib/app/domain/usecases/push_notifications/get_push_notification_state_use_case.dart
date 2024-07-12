part of 'push_notifications_use_cases.dart';

class GetStatusCheckUseCase {
  const GetStatusCheckUseCase({required NotficationRepository repository})
      : _fbPushNotificationRepoImpl = repository;
  final NotficationRepository _fbPushNotificationRepoImpl;

  Future<AuthorizationStatus> call() => _fbPushNotificationRepoImpl.getStatus();
}

// class GetStatusCheckUseCase {
//   const GetStatusCheckUseCase(
//       {required FBPushNotificationRepoImpl repository})
//       : _fbPushNotificationRepoImpl = repository;
//   final FBPushNotificationRepoImpl _fbPushNotificationRepoImpl;

//   Future<AuthorizationStatus> call() =>
//       _fbPushNotificationRepoImpl.statusCheck();
// }
