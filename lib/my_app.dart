import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/features/auth/auth_injection.dart';
import 'package:swift_cart/features/auth/login.dart';
import 'package:swift_cart/features/splash/splash.dart';
import 'bottom_navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthInjection.authCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Swift Cart',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        ),
        home: const Splash(),
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => const BottomNavigator(),
        },
      ),
    );
  }
}
