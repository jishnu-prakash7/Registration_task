import 'package:registration/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String name,
  });
  Future<DataState<Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
  Future<DataState<Map<String, dynamic>>> getUserDetails({
    required String uid
  });
}
