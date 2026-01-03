part of 'dependencies.dart';

void injectDataSources() {
  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );


}
