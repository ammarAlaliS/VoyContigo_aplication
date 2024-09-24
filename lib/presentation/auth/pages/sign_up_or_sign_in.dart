// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_page.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_in_page.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class SignUpOrSignIn extends StatelessWidget {
  const SignUpOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final white = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secudaryTextColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBg,
        body: Stack(
          children: [
            SvgPicture.asset(
              AppVectors.texture,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: isDarkMode
                  ? const Color.fromARGB(255, 14, 14, 14)
                  : const Color.fromARGB(255, 243, 243, 243),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                AppVectors.topPattern,
                color: isDarkMode
                    ? Colors.cyan
                    : const Color.fromARGB(255, 4, 4, 4),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                AppVectors.buttomPattern,
                color: isDarkMode
                    ? Colors.cyan
                    : const Color.fromARGB(255, 4, 4, 4),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                AppImages.transportImg,
                width: 250,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Logo(),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Quickcar",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Eina02',
                                color: isDarkMode
                                    ? Color(
                                        0xFF02EAFF) // Color para modo oscuro
                                    : const Color.fromARGB(255, 24, 24, 35), // Color para modo claro
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Viaja a cualquier destino',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Descubre nuevos destinos y vive experiencias únicas. Viaja con libertad a cualquier lugar del mundo.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: secudaryTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterPage(),
                                  ),
                                );
                              },
                              title: 'Registrarse',
                              height: 45,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignInPage(),
                                  ),
                                );
                              },
                              title: 'Iniciar Sesión',
                              height: 45,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      BasicAppButton(
                        onPressed: () {},
                        title: '¿Qué es Quickcar?',
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
