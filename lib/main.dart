import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'core/utils/bloc_observer.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppCubitObserver();
  runApp(const MyApp());
}