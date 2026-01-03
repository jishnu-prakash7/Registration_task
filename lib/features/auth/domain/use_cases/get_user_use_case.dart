import 'package:registration/core/resources/data_state.dart';
import 'package:registration/core/resources/use_case.dart';
import 'package:registration/features/auth/domain/repository/auth_repository.dart';

class GetUserUseCase
    implements UseCase<DataState<Map<String, dynamic>>, String> {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  @override
  Future<DataState<Map<String, dynamic>>> call({required String params}) async {
    return await _authRepository.getUserDetails(uid: params);
  }
}
