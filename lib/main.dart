import 'package:flutter/material.dart';

import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'core/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  // await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(MyApp(
    authenticationRepository: authenticationRepository,
  ));
}
