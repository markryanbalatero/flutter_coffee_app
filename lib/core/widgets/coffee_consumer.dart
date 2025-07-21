import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/coffee/coffee_cubit.dart';
import '../../cubit/coffee/coffee_stream_cubit.dart';
import '../../core/models/coffee_item.dart';

class CoffeeConsumer extends StatelessWidget {
  final Widget Function(BuildContext context, List<CoffeeItem> coffees) builder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final bool useStream;

  const CoffeeConsumer({
    super.key,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    this.useStream = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useStream) {
      return BlocConsumer<CoffeeStreamCubit, CoffeeStreamState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return loadingBuilder?.call(context) ??
                const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return errorBuilder?.call(context, state.errorMessage!) ??
                Center(child: Text('Error: ${state.errorMessage}'));
          }

          return builder(context, state.coffees);
        },
      );
    }

    return BlocConsumer<CoffeeCubit, CoffeeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return loadingBuilder?.call(context) ??
              const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return errorBuilder?.call(context, state.errorMessage!) ??
              Center(child: Text('Error: ${state.errorMessage}'));
        }

        return builder(context, state.coffees);
      },
    );
  }
}

class CoffeeBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    List<CoffeeItem> coffees,
    bool isLoading,
  )
  builder;
  final bool useStream;

  const CoffeeBuilder({
    super.key,
    required this.builder,
    this.useStream = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useStream) {
      return BlocBuilder<CoffeeStreamCubit, CoffeeStreamState>(
        builder: (context, state) {
          return builder(context, state.coffees, state.isLoading);
        },
      );
    }

    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (context, state) {
        return builder(context, state.coffees, state.isLoading);
      },
    );
  }
}
