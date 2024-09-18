import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotficationRepository {
  /// Loads the User's preferred ThemeMode from local storage.
  // AppThemeMode themeMode();
  // AppThemeMode get themeMode;

  /// Persists the user's preferred ThemeMode to local  storage.
  Future<AuthorizationStatus> getStatus();

  /// Metodo que cambia el estado de perimosos segun opcion, para usar
  /// notificaicones
  /// Permisos Dnegados devuelve null
  /// Permisos Consedidos devuelve el TOKENFCM
  Future<AuthorizationStatus> requestPermission();
  Future<bool> toogleStatus(bool request);

  /// Subscribir a topicos
  /// notificaicones
  /// Permisos Dnegados devuelve null
  /// Permisos Consedidos devuelve el TOKENFCM
  Future<void> subscribeTotopics(List<String> topics);
  Future<void> dellFCM();

  Future<void> deactivateNotifiactions();
  Future<bool?> getUserActiveNotification();
}
