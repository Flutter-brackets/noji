import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/features/splash/cubit/splash_cubit.dart';
import 'package:noji/features/splash/presentation/widgets/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit()..initialize(),
      child: const SplashView(),
    );
  }
}
