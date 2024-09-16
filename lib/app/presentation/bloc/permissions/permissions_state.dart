part of 'permissions_bloc.dart';

class PermissionsState extends Equatable {
  const PermissionsState({
    this.camera = PermissionStatus.denied,
    this.pthotoLibrary = PermissionStatus.denied,
    this.notification = PermissionStatus.denied,
  });

  final PermissionStatus camera;
  final PermissionStatus pthotoLibrary;
  final PermissionStatus notification;

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? pthotoLibrary,
    PermissionStatus? notification,
  }) {
    return PermissionsState(
      camera: camera ?? this.camera,
      pthotoLibrary: pthotoLibrary ?? this.pthotoLibrary,
      notification: notification ?? this.notification,
    );
  }

  get cameraGranted => camera.isGranted;
  get pthotoLibraryGranted => pthotoLibrary.isGranted;
  get notificationGranted => notification.isGranted;

  @override
  List<Object> get props => [
        camera,
        pthotoLibrary,
        notification,
      ];
}
