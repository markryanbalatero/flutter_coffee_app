import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/coffee_splash.png',
                  width: 320,
                  height: 360,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 480,
              left: 0,
              right: 0,
              child: Column(
                spacing: 20,
                children: [
                  Text('Stay Focused', style: AppTheme.splashTitleStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37),
                    child: Text(
                      'Get the cup filled of your choice to stay focused and awake. Different types of coffee menu — hot latte, cappuccino, and more.',
                      textAlign: TextAlign.center,
                      style: AppTheme.splashDescriptionStyle,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor.withAlpha(
                          (0.7 * 255).round(),
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.buttonColor.withAlpha(
                              (0.5 * 255).round(),
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Text('Dive In',
                              style: AppTheme.splashButtonTextStyle),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.buttonTextColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), // Scaffold body
      ), // PopScope
    ); // Scaffold
  }
}
