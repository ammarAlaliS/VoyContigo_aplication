// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/basic_app_select_theme.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_up_or_sign_in.dart';
import 'package:quickcar_aplication/presentation/choice_mode/bloc/theme_cubit.dart';
import 'package:quickcar_aplication/presentation/intro/set_system_color.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class ChoiceMode extends StatelessWidget {
  const ChoiceMode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
        // Obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Ajustar los tamaños de fuente basados en el ancho de la pantalla
    double titleFontSize = screenWidth * 0.07; // 6% del ancho de la pantalla

    // Asegurar que tanto la barra de estado como la barra de navegación sean transparentes
    setSystemUIOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors
          .transparent, // Hacer que la barra de navegación sea transparente
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.light : Brightness.dark,
    );

    return Scaffold(
      extendBody: true, // Extiende el cuerpo detrás de la barra de navegación
      extendBodyBehindAppBar:
          true, // Permite que el cuerpo de la app esté detrás de la barra de estado
      body: Stack(
        children: [
          // Imagen de fondo
           SvgPicture.asset(
              AppVectors.texture,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: isDarkMode
                  ? const Color.fromARGB(255, 14, 14, 14)
                  : const Color.fromARGB(109, 224, 224, 224),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 0, bottom: 120, left: 0),
            child: Column(
              children: [
                // Logo con efecto de blur
                ClipRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 3.0),
                      child: Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(vertical: 60),
                        decoration: BoxDecoration(
                           color: Color.fromARGB(255, 219, 255, 238),
                          shape: BoxShape.circle,
                        ),
                        child: Logo(),
                      )),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Seleccione un modo',
                        style: TextStyle(
                          fontSize: titleFontSize, // Tamaño de fuente ajustable
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.black,
                          letterSpacing: -2),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Botón para activar el modo oscuro
                          BasicAppSelectTheme(
                            initialCircleColor: isDarkMode
                                ? const Color.fromARGB(255, 2, 255, 188)
                                : const Color.fromARGB(255, 76, 76, 76),
                            initialIcon: SvgPicture.asset(AppVectors.moon),
                            labelText: 'Oscuro',
                            initialBorderColor: Colors.white,
                            textColor: Colors.grey,
                            onTap: () {
                              context
                                  .read<ThemeCubit>()
                                  .updateTheme(ThemeMode.dark);
                            },
                          ),
                          const SizedBox(width: 40),
                          // Botón para activar el modo claro
                          BasicAppSelectTheme(
                            initialCircleColor: isDarkMode
                                ? const Color.fromARGB(255, 76, 76, 76)
                                : Colors.black,
                            initialIcon: SvgPicture.asset(AppVectors.sun),
                            labelText: 'Claro',
                            initialBorderColor: Colors.white,
                            textColor: Colors.grey,
                            onTap: () {
                              context
                                  .read<ThemeCubit>()
                                  .updateTheme(ThemeMode.light);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpOrSignIn(),
                              ),
                            );
                          },
                          title: 'CONTINUAR',
                          height: 45,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
