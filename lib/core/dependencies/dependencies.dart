// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:registration/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:registration/features/auth/data/repository/auth_repository_impl.dart';
import 'package:registration/features/auth/domain/repository/auth_repository.dart';
import 'package:registration/features/auth/domain/use_cases/get_user_use_case.dart';
import 'package:registration/features/auth/domain/use_cases/login_use_case.dart';
import 'package:registration/features/auth/domain/use_cases/register_use_case.dart';

part 'inject_data_sources.dart';
part 'inject_repositories.dart';
part 'inject_use_cases.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {

  // Data Sources
  injectDataSources();

  // Repositories
  injectRepositories();

  // Use Cases
  injectUseCases();
}
