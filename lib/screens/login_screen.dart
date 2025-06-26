import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import '../services/auth_service.dart';

// TODO: Add future authentication features
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  final ScrollController _scrollController = ScrollController();
  final _authService = AuthService();

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // TODO: Add proper input validation for future real authentication
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both username and password';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // TODO: Replace with real authentication API call
    _authService
        .loginAndNavigate(username, password, context)
        .then((success) {
          if (!success && mounted) {
            setState(() {
              _isLoading = false;
              // TODO: Implement more specific error messages based on API response
              _errorMessage = 'Invalid username or password';
            });
          }
        })
        .catchError((error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              // TODO: Add proper error logging and analytics
              _errorMessage = 'An error occurred. Please try again.';
            });
          }
        });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (keyboardVisible && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent * 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else if (!keyboardVisible && _scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: screenHeight + (keyboardVisible ? 100 : 0),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.25),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 75),
                  InputField(
                    hintText: 'Username',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  const SizedBox(height: 34),
                  CustomButton(
                    onPressed: _onLoginPressed,
                    isLoading: _isLoading,
                    text: 'Login',
                    icon: Icons.arrow_forward,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Image.asset(
                      'assets/images/coffee_splash.png',
                      width: 180,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
