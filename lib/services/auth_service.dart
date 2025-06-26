import 'dart:async';
import 'package:flutter/material.dart';

/// AuthService handles user authentication and navigation
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Hardcoded credentials for testing
  final Map<String, String> _credentials = {
    'admin': 'password',
    'user': '123456',
    'kopiko': 'brown',
  };
  bool _isAuthenticated = false;
  String? _currentUser;

  Future<bool> loginAndNavigate(
    String username,
    String password,
    BuildContext context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (_credentials.containsKey(username) && _credentials[username] == password) {
      _isAuthenticated = true;
      _currentUser = username;

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
      return true;
    }

    return false;
  }
  Future<void> logout(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isAuthenticated = false;
    _currentUser = null;

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  bool get isAuthenticated => _isAuthenticated;
  String? get currentUser => _currentUser;
}