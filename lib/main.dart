import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/firebase_options.dart';
import 'package:cache/cache.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/dependencies/app_dependencies.dart';
import 'core/app_bloc_observer.dart';

Future<void> main() async {
  await Environment.initEnvironment();

  WidgetsFlutterBinding.ensureInitialized();

  await CacheInitializer.initialize();

  // await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  /// SharedPreferences Instance
  await Hive.initFlutter();

  ///
  await Hive.openBox(ConstHiveBox.kHiveBoxName);
  Bloc.observer = const AppBlocObserver();

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
