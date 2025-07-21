import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/espresso_screen.dart';
import 'screens/add_coffee_screen.dart';
import 'cubit/dashboard/dashboard_cubit.dart';
import 'screens/profile_screen.dart'; // Import the new ProfileScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DashboardCubit())],
      child: MaterialApp(
        title: 'Coffee App',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/espresso': (context) => const EspressoScreen(),
          '/add-coffee': (context) => AddCoffeeScreen.create(),
          '/profile': (context) => const ProfileScreen(), // Add the ProfileScreen route
        },
      ),
    );
  }
}
