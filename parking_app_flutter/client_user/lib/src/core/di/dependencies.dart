import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../../../firebase_options.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../domain/interfaces/auth_repository.dart';
import '../../domain/use_cases/auth.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../cubits/app_user/app_user_cubit.dart';
import '../cubits/navigation/bottom_navigation_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
  }

  // !: Firebase
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  // !: App User
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // !: Auth
  serviceLocator
    // !: Repositories
    ..registerFactory<AuthRepository>(
      () => FirebaseAuthRepository(firebaseAuth: serviceLocator()),
    )
    // !: Use Cases
    ..registerFactory(
      () => CurrentUserUseCase(authRepository: serviceLocator()),
    )
    ..registerFactory(
      () => UserSignOutUseCase(authRepository: serviceLocator()),
    )
    ..registerFactory(
      () => UserSignUpUseCase(authRepository: serviceLocator()),
    )
    ..registerFactory(
      () => UserSignInUseCase(authRepository: serviceLocator()),
    )
    // !: Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        currentUserUseCase: serviceLocator(),
        userSignOutUseCase: serviceLocator(),
        userSignUpUseCase: serviceLocator(),
        userSignInUseCase: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );

  // !: Bottom Navigation
  serviceLocator.registerLazySingleton(() => BottomNavigationCubit());
}