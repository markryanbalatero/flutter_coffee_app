import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../screens/dashboard_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthService _authService = AuthService();

  void login(String username, String password, BuildContext context) async {
    emit(LoginInitial());
    if (username.trim().isEmpty || password.isEmpty) {
      emit(LoginValidationError('Please enter both username and password'));
      return;
    }
    emit(LoginLoading());

    try {
      final success = await _authService.loginAndNavigate(
        username,
        password,
        context,
      );

      if (success) {
        emit(LoginSuccess());
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        emit(LoginError('Invalid username or password'));
      }
    } catch (error) {
      emit(LoginError('An error occurred. Please try again.'));
    }
  }

  void clearError() {
    if (state is LoginError || state is LoginValidationError) {
      emit(LoginInitial());
    }
  }

  void reset() {
    emit(LoginInitial());
  }
}
