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
  final _controller = StreamController<User>();

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
    yield* _controller.stream;
  }

  void dispose() => _controller.close();

  final StreamController<User> _userController =
      StreamController<User>.broadcast();

  Stream<User> get user2 => _userController.stream;

  Stream<User> get user {
    return Stream.value(User.empty);
  }

  Future<User> validateAccount() async {
    try {
      // Lógica para validar la cuenta. Puede involucrar llamadas a APIs, etc.
      // Simulando una validación:
      bool isValid = currentUser != User.empty;

      if (isValid) {
        // Suponiendo que se pueda obtener el usuario actual después de la validación

        return currentUser; // Retornar usuario actual si sigue autenticado
      } else {
        return User.empty;
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

    final user = User.fromJson(cacheUser);
    return user;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      // await _firebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      // } on firebase_auth.FirebaseAuthException catch (e) {
      //   throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://149.56.110.32:8086',
  ));

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String usuario,
    required String password,
  }) async {
    try {
      const urlLogin = '/login';
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

      final String token = loginData['token'];
      final int userId = loginData['id'];

      // Segunda solicitud para obtener los datos del usuario con el token
      final urlUserDetails = '/usuarios/$userId';
      final userResponse = await dio.get(
        urlUserDetails,
        options: Options(
          headers: {'Authorization': token},
        ),
      );

      if (userResponse.statusCode != 200) {
        throw const LogInWithEmailAndPasswordFailure(
            message: "Error al obtener datos del usuario");
      }

      final userData = userResponse.data;

      final UserResponse userResponseData = UserResponse.fromJson(userData);
      final User user = User.fromUsuarioResponse(userResponseData, token);

      await _cache.write(key: userCacheKey, value: user.toJson());
      _controller.add(user);
    } on DioException catch (dioError) {
      if (dioError.response!.statusCode == 404 ||
          dioError.response!.statusCode == 400) {
        final String? message = dioError.response!.data['message'];
        throw LogInWithEmailAndPasswordFailure(
            message: message ?? "Error en la red o del servidor");
      } else {
        throw throw LogInWithEmailAndPasswordFailure(
            message: dioError.response?.statusMessage ??
                "Error en la red o del servidor");
      }
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure(
          message: "Error desconocido durante el inicio de sesión");
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    _cache.clear();
    _controller.add(User.empty);
    //   try {
    //     await Future.wait([
    //       _firebaseAuth.signOut(),
    //       _googleSignIn.signOut(),
    //     ]);
    //   } catch (_) {
    //     throw LogOutFailure();
    //   }
    // }
  }
}
