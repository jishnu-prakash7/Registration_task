import 'package:flutter/material.dart';
import 'package:registration/core/dependencies/dependencies.dart';
import 'package:registration/features/auth/domain/use_cases/get_user_use_case.dart';
import 'package:registration/features/auth/domain/use_cases/login_use_case.dart';
import 'package:registration/features/auth/domain/use_cases/register_use_case.dart';

class AuthProvider extends ChangeNotifier {
  bool signupLoading = false;
  String signupError = '';
  String signupSuccess = '';
  Map<String, dynamic> signupResponse = {};

  bool loginLoading = false;
  String loginError = '';
  String loginSuccess = '';
  Map<String, dynamic> loginResponse = {};

  bool getUserLoading = false;
  String getUserError = '';
  String getUserSuccess = '';
  Map<String, dynamic> getUserResponse = {};

  signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      signupLoading = true;
      signupError = '';
      signupSuccess = '';
      notifyListeners();
      Map<String, dynamic> params = {
        "email": email,
        "password": password,
        "name": name,
      };
      final result = await getIt<RegisterUseCase>().call(params: params);

      signupLoading = false;

      if (result.error != null) {
        signupError = result.error!.message;
      } else {
        signupSuccess = 'User created succesfully';
        signupResponse = result.data ?? {};
      }
      notifyListeners();
    } catch (e) {
      signupLoading = false;
      signupError = e.toString();
      notifyListeners();
    }
  }

  login({required String email, required String password}) async {
    try {
      loginLoading = true;
      loginError = '';
      loginSuccess = '';
      notifyListeners();
      Map<String, dynamic> params = {"email": email, "password": password};
      final result = await getIt<LoginUseCase>().call(params: params);

      loginLoading = false;

      if (result.error != null) {
        loginError = result.error!.message;
      } else {
        loginSuccess = 'User logged in successfully';
        loginResponse = result.data ?? {};
      }
      notifyListeners();
    } catch (e) {
      loginLoading = false;
      loginError = e.toString();
      notifyListeners();
    }
  }

  getUserDetails({required String uid}) async {
    try {
      getUserLoading = true;
      getUserError = '';
      getUserSuccess = '';
      notifyListeners();

      final result = await getIt<GetUserUseCase>().call(params: uid);

      getUserLoading = false;

      if (result.error != null) {
        getUserError = result.error!.message;
      } else {
        getUserSuccess = 'User logged in successfully';
        getUserResponse = result.data ?? {};
      }
      notifyListeners();
    } catch (e) {
      getUserLoading = false;
      getUserError = e.toString();
      notifyListeners();
    }
  }

  void clearMessages() {
    signupError = '';
    signupSuccess = '';
    loginSuccess = '';
    loginResponse = {};
    loginResponse = {};
    loginError = '';
    notifyListeners();
  }
}
