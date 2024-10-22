// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/choice_mode/pages/choice_mode.dart';
import 'package:quickcar_aplication/presentation/intro/pages/get_started_page.dart';
import 'package:quickcar_aplication/presentation/intro/set_system_color.dart';
import 'package:quickcar_aplication/presentation/root/pages/root.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

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
    final isDarkMode = theme.brightness == Brightness.dark;

    setSystemUIOverlayStyle(
      statusBarColor:
          isDarkMode ? Colors.black : Color.fromARGB(255, 219, 255, 238),
      systemNavigationBarColor:
          isDarkMode ? Colors.black : Color.fromARGB(255, 219, 255, 238),
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.light : Brightness.dark,
    );

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150, // Asegúrate de que el ancho sea igual a la altura
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 219, 255, 238),
                shape: BoxShape.circle,
              ),
              child: Center(
                // Centra el contenido
                child: Logo(),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color:
                    isDarkMode ? Colors.white : Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: splashDuration));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Verificar si el token del usuario sigue siendo válido
        await user.getIdToken(true); // Fuerza la actualización del token

        // Si el usuario sigue autenticado, redirige a RootPage
        print("Current user: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => RootPage()),
        );
      } catch (e) {
        // Si hay un error (como que el usuario ya no existe), cierra la sesión
        print("User no longer exists. Signing out.");
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ChoiceMode()),
        );
      }
    } else {
      // Si no hay usuario autenticado, redirige a GetStartedPage
      print("No user is signed in. Redirecting to GetStartedPage.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ChoiceMode()),
      );
    }
  }
}
