part of 'dependencies.dart';

void injectUseCases() {
  // Register
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));

  // Login
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));

  // Get User
  getIt.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(getIt()));
}
