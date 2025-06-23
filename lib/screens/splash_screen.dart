import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE0D1),
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
                const Text(
                  'Stay Focused',
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFF38220F),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 37),
                  child: Text(
                    'Get the cup filled of your choice to stay focused and awake. Diffrent type of coffee menu, hot lottee cappucino',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 22 / 14,
                      color: Color(0x99444444),
                    ),
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
                      color: const Color(0xFF967259).withAlpha((0.7 * 255).round()),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF967259).withAlpha((0.5 * 255).round()),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                  ),
                  // Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF967259),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      elevation: 0,
                    ),
                    onPressed: () {
                      /// TODO: Add navigation or next action
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Dive In',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
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
