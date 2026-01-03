import 'package:registration/core/resources/data_state.dart';
import 'package:registration/core/resources/use_case.dart';
import 'package:registration/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase
    implements UseCase<DataState<Map<String, dynamic>>, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<Map<String, dynamic>>> call({
    required Map<String, dynamic> params,
  }) async {
    return await _authRepository.register(
      email: params["email"],
      password: params["password"],
      name: params["name"],
    );
  } 
}
