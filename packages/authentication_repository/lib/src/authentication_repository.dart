import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:shared_models/shared_models.dart';

// import 'models/user_response.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  // final _controller = StreamController<User>();

  AuthenticationRepository({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient() {
    _userController.add(User.empty);
  }

  final CacheClient _cache;

  static const userCacheKey = '__user_cache_key__';

  Stream<User> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield currentUser;
    yield* _userController.stream;
  }

  void dispose() => _userController.close();

  final StreamController<User> _userController =
      StreamController<User>.broadcast();

  Stream<User> get user {
    return Stream.value(User.empty);
  }

  Future<User> validateAccount() async {
    try {
      // Lógica para validar la cuenta. Puede involucrar llamadas a APIs, etc.
      // Simulando una validación:
      // bool isValid = currentUser != User.empty;
      // Obtener el usuario actual del caché
      final currentUserValidate = currentUser;

      // Verificar si el token del usuario es válido (esto es opcional y depende de tu lógica)
      // Aquí podrías hacer una llamada a un endpoint que valide el token TODO; validae token

      // Verificar si hay un usuario autenticado en caché
      if (currentUserValidate.isEmpty) {
        return User.empty; // No hay usuario autenticado
      }

      try {
        final urlUserDetails = '/usuarios/${currentUserValidate.id}';
        final userResponse = await dio.get(
          urlUserDetails,
          options: Options(
            headers: {'Authorization': currentUserValidate.token},
          ),
        );

        if (userResponse.statusCode != 200) {
          throw const LogInWithEmailAndPasswordFailure(
              message: "Error al obtener datos del usuario");
        }

        final userData = userResponse.data;

        final UserResponse userResponseData = UserResponse.fromJson(userData);
        final rolId = userData['rol']['id'];
        User updatedUser;
        switch (rolId) {
          case 3: // Cliente
            // Consumir el servicio adicional para obtener más detalles del cliente
            final urlClientDetails = '/clientes/${currentUserValidate.id}';
            final clientResponse = await dio.get(
              urlClientDetails,
              options: Options(
                  headers: {'Authorization': currentUserValidate.token}),
            );

            if (clientResponse.statusCode != 200) {
              throw const LogInWithEmailAndPasswordFailure(
                  message: "Error al obtener datos del cliente");
            }

            // Parseamos los datos adicionales del cliente
            final clientData = clientResponse.data;
            final UsrClienteResponse userClientData =
                UsrClienteResponse.fromJson(clientData);
            updatedUser = UsrCliente.fromUsuarioResponse(
                userClientData, currentUserValidate.token!);
            break;

          case 4: // Agente
            // Consumir el servicio adicional para obtener más detalles del agente
            final urlAgenteDetails = '/agentes/$currentUserValidate.id';
            final agentResponse = await dio.get(
              urlAgenteDetails,
              options: Options(
                  headers: {'Authorization': currentUserValidate.token}),
            );

            if (agentResponse.statusCode != 200) {
              throw const LogInWithEmailAndPasswordFailure(
                  message: "Error al obtener datos del agente");
            }

            // Parseamos los datos adicionales del agente
            final agentData = agentResponse.data;
            final UsrAgenteResponse userAgentData =
                UsrAgenteResponse.fromJson(agentData);
            updatedUser = UsrAgente.fromUsuarioResponse(
                userAgentData, currentUserValidate.token!);
            break;
          case 2:
            updatedUser = User.fromUsuarioResponse(userResponseData,
                currentUserValidate.token!); // Devuelve un User genérico
            break;
          default:
            updatedUser = User.fromUsuarioResponse(userResponseData,
                currentUserValidate.token!); // Devuelve un User genérico
        }

        await _cache.write(key: userCacheKey, value: updatedUser.toJson());

        return updatedUser; // Retornar el usuario actualizado
      } catch (e) {
        // Si hay un error al obtener los datos actualizados, retornar el usuario en caché
        return currentUser;
      }
    } catch (e) {
      // Manejar excepciones si algo falla durante la validación
      print('Error during account validation: $e');
      return User.empty;
    }
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    // _cache.clear();

    final cacheUser = _cache.readMap(key: userCacheKey);
    if (cacheUser == null) {
      return User.empty;
    }

    final rolId = cacheUser['rol']['id'];
    if (rolId == null) {
      return User.empty;
    }
    User user;
    switch (rolId) {
      case 3: // Cliente
        user = UsrCliente.fromJson(cacheUser);
      case 4: // Agente
        user = UsrAgente.fromJson(cacheUser);
        break;
      default:
        user = User.fromJson(cacheUser);
    }
    return user;
  }

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://149.56.110.32:8086',
  ));

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<Map<String, dynamic>> logInWithEmailAndPassword({
    required String usuario,
    required String password,
  }) async {
    try {
      const urlLogin = '/login?generate2FA=SI';
      final data = {'usuario': usuario, 'contrasenia': password};
      final loginResponse = await dio.post(
        urlLogin,
        data: data,
      );

      if (loginResponse.statusCode != 200) {
        final responseData = loginResponse.data;

        throw LogInWithEmailAndPasswordFailure(
            message:
                responseData['message'] ?? "Error durante la autenticación");
      }

      final loginData = loginResponse.data;
      if (loginData is! Map<String, dynamic> ||
          !loginData.containsKey('token')) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Datos de autenticación no válidos");
      }

      // final String token = loginData['token'];
      // final int userId = loginData['id'];
      // Devuelve el token para usarlo más adelante en la validación del código 2FA
      return loginData;
    } on DioException catch (dioError) {
      throw LogInWithEmailAndPasswordFailure(
          message: dioError.response?.data['message'] == null
              ? "Error en la red o del servidor"
              : dioError.response?.data['message']! == 'Credenciales inválidas'
                  ? 'Invalid username or password'
                  : dioError.response?.data['message']!);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error desconocido durante el inicio de sesión");
    }
  }

  // Método para verificar el código de 2FA
  Future<void> verifyTwoFactorCode({
    required String usuario,
    required String userId,
    required String codigo,
    required String token,
  }) async {
    try {
      const urlVerify = '/verify-code';
      final data = {'usuario': usuario, 'codigo': codigo};
      final response = await dio.post(
        urlVerify,
        data: data,
        options: Options(headers: {'Authorization': token}),
      );

      if (response.statusCode != 200 || !response.data['success']) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Código de verificación incorrecto");
      }

      // Si es exitoso, cargar los detalles del usuario
      await _fetchUserDetails(token, userId);
    } on DioException catch (dioError) {
      throw LogInWithEmailAndPasswordFailure(
          message: dioError.response?.data['message'] ??
              "Error en la red o del servidor");
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error desconocido durante la verificación");
    }
  }

  // Método para obtener los detalles del usuario una vez validado el 2FA
  Future<void> _fetchUserDetails(String token, String userId) async {
    try {
      final urlUserDetails = '/usuarios/$userId';
      final userResponse = await dio.get(
        urlUserDetails,
        options: Options(headers: {'Authorization': token}),
      );

      if (userResponse.statusCode != 200) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Error al obtener datos del usuario");
      }

      // final userData = userResponse.data;
      // final User user = User.fromJson(userData);

      final userData = userResponse.data;

      final UserResponse userResponseData = UserResponse.fromJson(userData);
      // final User user = User.fromUsuarioResponse(userResponseData, token);
      final rolId = userData['rol']['id'];
      User user;
      switch (rolId) {
        case 3: // Cliente
          // Consumir el servicio adicional para obtener más detalles del cliente
          final urlClientDetails = '/clientes/$userId';
          final clientResponse = await dio.get(
            urlClientDetails,
            options: Options(headers: {'Authorization': token}),
          );

          if (clientResponse.statusCode != 200) {
            throw const LogInWithEmailAndPasswordFailure(
                message: "Error al obtener datos del cliente");
          }

          // Parseamos los datos adicionales del cliente
          final clientData = clientResponse.data;
          final UsrClienteResponse userClientData =
              UsrClienteResponse.fromJson(clientData);
          user = UsrCliente.fromUsuarioResponse(userClientData, token);
          break;

        case 4: // Agente
          // Consumir el servicio adicional para obtener más detalles del agente
          final urlAgenteDetails = '/agentes/$userId';
          final agentResponse = await dio.get(
            urlAgenteDetails,
            options: Options(headers: {'Authorization': token}),
          );

          if (agentResponse.statusCode != 200) {
            throw const LogInWithEmailAndPasswordFailure(
                message: "Error al obtener datos del agente");
          }

          // Parseamos los datos adicionales del agente
          final agentData = agentResponse.data;
          final UsrAgenteResponse userAgentData =
              UsrAgenteResponse.fromJson(agentData);
          user = UsrAgente.fromUsuarioResponse(userAgentData, token);
          break;
        case 2:
          user = User.fromUsuarioResponse(
              userResponseData, token); // Devuelve un User genérico
          break;
        default:
          user = User.fromUsuarioResponse(
              userResponseData, token); // Devuelve un User genérico
      }

      //TODO: refat
      await _cache.write(key: userCacheKey, value: user.toJson());
      _userController.add(user);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error al obtener datos del usuario");
    }
  }

  Future<void> changePassword({
    required String usuario,
    required String contraseniaActual,
    required String contraseniaNueva,
    required String token,
  }) async {
    try {
      const url = '/change-password';
      final data = {
        'usuario': usuario,
        'contraseniaActual': contraseniaActual,
        'contraseniaNueva': contraseniaNueva,
      };
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': token}),
      );

      if (response.statusCode != 200) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Error al cambiar la contraseña");
      }
    } on DioException catch (e) {
      // Si no hay respuesta del servidor
      if (e.response == null) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Error de red o servidor no disponible");
      }

      // Manejo del error con código 400 y "CONTRASENIA_INCORRECTA"
      if (e.response!.statusCode == 400) {
        final responseData = e.response!.data;

        // Verificamos si el asunto es "CONTRASENIA_INCORRECTA"
        if (responseData != null) {
          throw LogInWithEmailAndPasswordFailure(
              message: responseData['message']);
        }

        // Si es otro error 400, manejamos de manera genérica
        throw const LogInWithEmailAndPasswordFailure(
            message: "Error durante el cambio de contraseña");
      }

      // Otros errores HTTP
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error desconocido durante el cambio de contraseña");
    } catch (e) {
      // Manejar cualquier otro error
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error inesperado durante el cambio de contraseña");
    }
  }

  Future<void> requesResetPsw(String email) async {
    try {
      const urlVerify = '/sendCodeByMail';
      final data = {'correoElectronico': email};
      final response = await dio.post(
        urlVerify,
        data: data,
      );

      if (response.statusCode != 200 || !response.data['success']) {
        throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
      }

      // Si es exitoso, cargar los detalles del usuario
    } on DioException catch (_) {
      throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error desconocido durante la verificación");
    }
  }

  Future<void> restartPassword(String correoElectronico, String codigo2FA,
      String contraseniaNueva) async {
    try {
      const urlVerify = '/restart-password';
      final data = {
        'correoElectronico': correoElectronico,
        'codigo2FA': codigo2FA,
        'contraseniaNueva': contraseniaNueva
      };
      final response = await dio.post(
        urlVerify,
        data: data,
      );

      if (response.statusCode != 200 || !response.data['success']) {
        throw LogInWithEmailAndPasswordFailure(
          message:
              response.data['message'] ?? 'Error al reiniciar la contraseñaaa',
        );
      }

      // Si es exitoso, cargar los detalles del usuario
    } on LogInWithEmailAndPasswordFailure {
      rethrow;
    } on DioException catch (_) {
      throw const LogInWithEmailAndPasswordFailure(
        message: 'Error al reiniciar la contraseña',
      );
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
        message: 'Error al reiniciar la contraseña',
      );
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    await _cache.clear();
    _userController.add(User.empty);
  }
}


//  /// Creates a new user with the provided [email] and [password].
//   ///
//   /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       // await _firebaseAuth.createUserWithEmailAndPassword(
//       //   email: email,
//       //   password: password,
//       // );

//       // } on firebase_auth.FirebaseAuthException catch (e) {
//       //   throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw const SignUpWithEmailAndPasswordFailure();
//     }
//   }