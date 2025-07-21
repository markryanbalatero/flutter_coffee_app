import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/google_sign_in_button.dart';
import '../cubit/login/login_cubit.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    context.read<LoginCubit>().login(email, password, context);
  }

  @override
  void dispose() {
    _emailController.dispose();
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
        body: Theme(
          data: Theme.of(context).copyWith(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                _emailController.clear();
                _passwordController.clear();
              }
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.2),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Login', style: AppTheme.loginTitleStyle),
                    ),
                    const SizedBox(height: 60),
                    InputField(
                      hintText: 'Email',
                      controller: _emailController,
                      onChanged: (value) {
                        context.read<LoginCubit>().clearError();
                      },
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: _passwordController,
                      onChanged: (value) {
                        context.read<LoginCubit>().clearError();
                      },
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginError ||
                            state is LoginValidationError) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              state is LoginError
                                  ? state.message
                                  : (state as LoginValidationError).message,
                              style: AppTheme.loginErrorStyle,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        final isEmailLoading = state is LoginLoading &&
                            state.type == LoginType.email;
                        return CustomButton(
                          onPressed: _onLoginPressed,
                          isLoading: isEmailLoading,
                          text: 'Login',
                          icon: Icons.arrow_forward,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppColors.dividerColor)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: AppColors.dividerTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: AppColors.dividerColor)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        final isGoogleLoading = state is LoginLoading &&
                            state.type == LoginType.google;
                        return GoogleSignInButton(
                          onPressed: () {
                            context
                                .read<LoginCubit>()
                                .signInWithGoogle(context);
                          },
                          isLoading: isGoogleLoading,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account? Register',
                          style: TextStyle(
                            color: AppTheme.buttonColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.00),
                    Image.asset(
                      'assets/images/coffee_splash.png',
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
