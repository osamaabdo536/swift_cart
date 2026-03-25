import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/cart/cubit/cart_cubit.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_cubit.dart';
import 'core/utils/bloc_observer.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppCubitObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteCubit()),
        BlocProvider(create: (_) => CartCubit()..getCart()),
      ],
      child: const MyApp(),
    ),
  );
}