import 'package:registration/core/resources/data_state.dart';
import 'package:registration/core/resources/use_case.dart';
import 'package:registration/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase
    implements UseCase<DataState<Map<String, dynamic>>, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<Map<String, dynamic>>> call({
    required Map<String, dynamic> params,
  }) async {
    return await _authRepository.login(
      email: params["email"],
      password: params["password"]
    );
  }
}
