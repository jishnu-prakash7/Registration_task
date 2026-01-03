import 'package:flutter/material.dart';
import 'package:registration/core/resources/data_state.dart';
import 'package:registration/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:registration/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<DataState<Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final res = await _authRemoteDataSource.singup(
        email: email,
        password: password,
        name: name,
      );

      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _authRemoteDataSource.login(
        email: email,
        password: password,
      );

      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Map<String, dynamic>>> getUserDetails({
    required String uid,
  }) async {
    try {
      final res = await _authRemoteDataSource.getUser(uid: uid);

      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }
}
