// import 'dart:developer' as developer;
// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';

// /// Clase [FBRemoteConfingSource] para manejar la interacción tcon Firebase Remote Config.
// ///
// /// Esta clase encapsula las operaciones relacionadas con Firebase Remote Config,
// /// permitiendo inicializar, obtener y actualizar la configuración remota.
// class RemoteConfingSourcesFB {
//   /// Instancia de [FirebaseRemoteConfig] para interactuar con el servicio de Remote Conftig.
//   ///
//   RemoteConfingSourcesFB() : _remoteConfig = FirebaseRemoteConfig.instance;

//   final FirebaseRemoteConfig _remoteConfig;

//   /// Inicializa Firebase Remote Config con configuraciones específicas.
//   ///
//   /// Configura el tiempo de espera para la obtención (`fetchTimeout`) y el intervalo mínimo
//   /// para obtener actualizaciones (`minimumFetchInterval`).
//   ///
//   Future<void> initializeRemoteConfig() async {
//     try {
//       // await _remoteConfig.ensureInitialized();
//       await _remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(minutes: 1),
//         // minimumFetchInterval: const Duration(hours: 1),
//         minimumFetchInterval: Duration.zero,
//       ));
//       await _setDefaults();
//       await fetchAndActivate();
//     } on FirebaseException catch (e, st) {
//       developer.log(
//         'Unable to initialize Firebase Reomote Config',
//         error: e,
//         stackTrace: st,
//       );
//     }
//   }

//   /// Obtiene y activa los parámetros de configuración remota.
//   ///
//   /// Este método intenta obtener la última configuración disponible y, si es exitoso,
//   /// activa dicha configuración para su uso en la aplicación.
//   Future<void> fetchAndActivate() async {
//     try {
//       await _remoteConfig.fetchAndActivate();
//       // await _remoteConfig.activate();
//     } catch (exception) {
//       // Maneja excepciones relacionadas con la obtención y activación de la configuración.
//       log("RemoteConfingSourcesFB -> Error al activar Remote Config: $exception");
//     }
//   }

//   /// Generan un configuracion por defecto
//   Future<void> _setDefaults() async => _remoteConfig.setDefaults(
//         const {
//           FirebaseRemoteConfigKeys.upslogoConmemorativo: false,
//         },
//       );

//   String getString(String key) => _remoteConfig.getString(key);
//   bool getBool(String key) => _remoteConfig.getBool(key);
//   int getInt(String key) => _remoteConfig.getInt(key);
//   double getDouble(String key) => _remoteConfig.getDouble(key);
// }
