// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/intro/pages/get_started_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const int splashDuration = 2;

  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo,
              height: 75,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: splashDuration));
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
          builder: (BuildContext context) => GetStartedPage(),
      ),
    );
  }
}
