import 'dart:async';

import 'package:avalon_app/app/presentation/bloc/app_cycle/app_lifecycle_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Cubit<PermissionsState> {
  PermissionsBloc(AppLifeCubit appLifeCubit) : super(const PermissionsState()) {
    checkPermissions();
    streamSubscription = appLifeCubit.stream.listen((event) {
      if (event == AppLifecycleState.resumed) {
        checkPermissions();
      }
    });
  }

  late StreamSubscription streamSubscription;

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.notification.status,
      // Permission.location.status,
      // Permission.locationAlways.status,
      // Permission.locationWhenInUse.status,
    ]);

    emit(state.copyWith(
      camera: permissionsArray[0],
      pthotoLibrary: permissionsArray[1],
      notification: permissionsArray[2],
      // location: permissionsArray[3],
      // locationAlways: permissionsArray[4],
      // locationWhenInUse: permissionsArray[5],
    ));
  }

  openSettingsPhone() {
    openAppSettings();
  }

  void _checkPermissionPermanetlyDenied(PermissionStatus status) {
    if (status.isPermanentlyDenied) {
      openSettingsPhone();
    }
  }

  requestCameraPermission() async {
    final status = await Permission.camera.request();
    emit(state.copyWith(camera: status));

    _checkPermissionPermanetlyDenied(status);
  }

  requestPthotoLibraryPermission() async {
    final status = await Permission.photos.request();
    emit(state.copyWith(pthotoLibrary: status));

    _checkPermissionPermanetlyDenied(status);
  }

  requestNotificationPermission() async {
    final status = await Permission.notification.request();
    emit(state.copyWith(notification: status));

    _checkPermissionPermanetlyDenied(status);
  }
}
