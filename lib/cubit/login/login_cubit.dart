import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../screens/dashboard_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthService _authService = AuthService();

  void login(String email, String password, BuildContext context) async {
    emit(LoginInitial());

    // Basic validation
    if (email.trim().isEmpty || password.isEmpty) {
      emit(LoginValidationError('Please enter both email and password'));
      return;
    }

    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      emit(LoginValidationError('Please enter a valid email address'));
      return;
    }

    emit(LoginLoading());

    try {
      final success = await _authService.loginAndNavigate(
        email,
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
        emit(LoginError('Authentication failed'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email address';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many failed attempts. Please try again later';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid email or password';
          break;
        default:
          errorMessage = 'Authentication failed. Please try again';
      }
      emit(LoginError(errorMessage));
    } catch (error) {
      emit(LoginError('An error occurred. Please try again.'));
    }
  }

  void signInWithGoogle(BuildContext context) async {
    emit(LoginLoading());

    try {
      final success = await _authService.signInWithGoogle(context);

      if (success) {
        emit(LoginSuccess());
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        emit(LoginError('Google sign-in was cancelled'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              'An account already exists with the same email address but different sign-in credentials';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid Google credentials';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google sign-in is not enabled';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled';
          break;
        default:
          errorMessage = 'Google sign-in failed. Please try again';
      }
      emit(LoginError(errorMessage));
    } catch (error) {
      emit(LoginError('Google sign-in failed. Please try again.'));
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
