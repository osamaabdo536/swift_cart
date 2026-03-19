import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/auth/auth_injection.dart';
import 'package:swift_cart/features/auth/login.dart';
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
        theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => BottomNavigator(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final repository = AuthInjection.repository;
    final isLoggedIn = await repository.isLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigator()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
