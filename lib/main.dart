import 'package:avalon_app/firebase_options.dart';
import 'package:cache/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/dependencies/app_dependencies.dart';
import 'core/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await CacheInitializer.initialize();

  // await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  // / Inizializar [Firebase]
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiRepositoryProvider(
      providers: AppDependencies.initDependencies(),
      child: MyApp(
        authenticationRepository: authenticationRepository,
      )));
}


/// TODO CAMBIAR PACKAGE ID EN IOS