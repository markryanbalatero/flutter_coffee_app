import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_theme.dart';
import '../widgets/input_field.dart';
import '../widgets/custom_button.dart';
import '../cubit/login/login_cubit.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    context.read<LoginCubit>().login(username, password, context);
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
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              _usernameController.clear();
              _passwordController.clear();
            }
          },
          child: SingleChildScrollView(
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
                      child: Text('Login', style: AppTheme.loginTitleStyle),
                    ),
                    const SizedBox(height: 75),
                    InputField(
                      hintText: 'Username',
                      controller: _usernameController,
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

                    const SizedBox(height: 34),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return CustomButton(
                          onPressed: _onLoginPressed,
                          isLoading: state is LoginLoading,
                          text: 'Login',
                          icon: Icons.arrow_forward,
                        );
                      },
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
      ),
    );
  }
}
