import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:google_sign_in/google_sign_in.dart';

import 'exceptions/authentication_repo_exceptions.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    // firebase_auth.FirebaseAuth? firebaseAuth,
    // GoogleSignIn? googleSignIn,
  }) : _cache = cache ?? CacheClient();
  // _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
  // _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  // final firebase_auth.FirebaseAuth _firebaseAuth;
  // final GoogleSignIn _googleSignIn;

  /// User cache key.
  /// Should only be used for testing purposes.

  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    // return _firebaseAuth.authStateChanges().map((firebaseUser) {
    //   final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
    //   _cache.write(key: userCacheKey, value: user);
    //   return user;
    // });
    return Stream.value(User.empty);

    // return Stream<User>.multi((controller) {
    //   // Emitir inmediatamente el usuario vacío
    //   controller.add(User.empty);

    //   // Después de un retraso, emitir un usuario con datos
    //   // Future.delayed(const Duration(seconds: 3), () {
    //   //   controller.add(const User(
    //   //     id: 'fadsfads',
    //   //     email: 'pabloa_ec@hotmail.com',
    //   //     name: 'Pablo Torres',
    //   //     photo: 'asdfadsf',
    //   //   ));
    //   //   // controller
    //   //   //     .close(); // Opcionalmente, puedes cerrar el stream después de emitir el segundo usuario
    //   // });
    // });
  }

  Future<User> validateAccount() async {
    try {
      // Lógica para validar la cuenta. Puede involucrar llamadas a APIs, etc.
      // Simulando una validación:
      bool isValid =
          true; // Esta línea debe reemplazarse con la lógica real de validación

      if (isValid) {
        // Suponiendo que se pueda obtener el usuario actual después de la validación
        await Future.delayed(const Duration(milliseconds: 200));
        // final currentUser2 = currentUser;
        return User.empty; // Retornar usuario actual si sigue autenticado
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
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
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

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    // try {
    //   late final firebase_auth.AuthCredential credential;

    //   final googleUser = await _googleSignIn.signIn();
    //   final googleAuth = await googleUser!.authentication;
    //   credential = firebase_auth.GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );

    //   await _firebaseAuth.signInWithCredential(credential);
    // } on firebase_auth.FirebaseAuthException catch (e) {
    //   throw LogInWithGoogleFailure.fromCode(e.code);
    // } catch (_) {
    //   throw const LogInWithGoogleFailure();
    // }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // try {
    //   await _firebaseAuth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    // } on firebase_auth.FirebaseAuthException catch (e) {
    //   throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    // } catch (_) {
    //   throw const LogInWithEmailAndPasswordFailure();
    // }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
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
// extension on firebase_auth.User {
//   /// Maps a [firebase_auth.User] into a [User].
//   User get toUser {
//     return User(id: uid, email: email, name: displayName, photo: photoURL);
//   }
// }
//