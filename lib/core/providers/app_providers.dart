import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/coffee/coffee_cubit.dart';
import '../../cubit/coffee/coffee_stream_cubit.dart';
import '../../cubit/add_coffee/add_coffee_cubit.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoffeeCubit>(create: (context) => CoffeeCubit()),
        BlocProvider<CoffeeStreamCubit>(
          create: (context) => CoffeeStreamCubit(),
        ),
        BlocProvider<AddCoffeeCubit>(create: (context) => AddCoffeeCubit()),
      ],
      child: child,
    );
  }
}

class CoffeeProviders extends StatelessWidget {
  final Widget child;

  const CoffeeProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoffeeCubit>(
          create: (context) => CoffeeCubit()..loadCoffees(),
        ),
        BlocProvider<CoffeeStreamCubit>(
          create: (context) => CoffeeStreamCubit()..startListening(),
        ),
      ],
      child: child,
    );
  }
}
