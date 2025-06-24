import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Coffee cup image
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

          // Title and description
          Positioned(
            top: 480,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const AppText(
                  text: 'Stay Focused',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro Text',
                  color: AppColors.primaryText,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 37),
                  child: AppText(
                    text:
                        'Get the cup filled of your choice to stay focused and awake. Different types of coffee menu — hot latte, cappuccino, and more.',
                    fontSize: 14,
                    color: AppColors.secondaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          // Dive In button
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Blurred shadow
                  Container(
                    width: 120,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.button.withAlpha((0.7 * 255).round()),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.button.withAlpha(
                            (0.5 * 255).round(),
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                  ),
                  // Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
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
                      // TODO: Add navigation or next screen
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        AppText(
                          text: 'Dive In',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
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
      ),
    );
  }
}
