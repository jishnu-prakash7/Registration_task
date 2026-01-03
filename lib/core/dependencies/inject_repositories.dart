part of 'dependencies.dart';

void injectRepositories() {
  // // Auth
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

}
