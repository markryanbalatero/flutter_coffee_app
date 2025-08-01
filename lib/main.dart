import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/espresso_screen.dart';
import 'screens/add_coffee_screen.dart';
import 'cubit/dashboard/dashboard_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'screens/profile_screen.dart'; // Import the new ProfileScreen
import 'cubit/favorite_cubit.dart';
import 'widgets/session_checker.dart';

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
      providers: [
        BlocProvider(create: (context) => DashboardCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Coffee App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const SessionChecker(),
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/dashboard': (context) => const DashboardScreen(),
              '/espresso': (context) {
                final coffee =
                    ModalRoute.of(context)!.settings.arguments as CoffeeItem?;
                return EspressoScreen(product: coffee);
              },
              '/add-coffee': (context) => AddCoffeeScreen.create(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
