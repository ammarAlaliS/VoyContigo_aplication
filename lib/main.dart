// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/theme/app_theme.dart';
import 'package:quickcar_aplication/presentation/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickCar',
      theme: AppTheme.lightTheme, 
      home: SplashPage(), 
    );
  }
}
