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
import 'package:quickcar_aplication/presentation/widgets/logo.dart';
class ChoiceMode extends StatelessWidget {
  const ChoiceMode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Imagen de fondo
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.choiceMode),
                ),
              ),
            ),
            // Capa semi-transparente
            Container(
              color: Colors.black.withOpacity(0.50),
            ),
            // Elementos sobrepuestos
            Padding(
              padding: const EdgeInsets.only(right: 0, bottom: 120, left: 0),
              child: Column(
                children: [
                  // Logo con efecto de blur
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 3.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: const Logo(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Seleccione un modo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
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
                                // Cambiar siempre al modo oscuro cuando se presione
                                context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                              },
                            ),
                            const SizedBox(width: 40),
                            // Botón para activar el modo claro
                            BasicAppSelectTheme(
                              initialCircleColor: isDarkMode
                                  ? const Color.fromARGB(255, 76, 76, 76)
                                  : const Color.fromARGB(255, 2, 255, 188),
                              initialIcon: SvgPicture.asset(AppVectors.sun),
                              labelText: 'Claro',
                              initialBorderColor: Colors.white,
                              textColor: Colors.grey,
                              onTap: () {
                                // Cambiar siempre al modo claro cuando se presione
                                context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: BasicAppButton(
                            onPressed: () {
                              // Acción al presionar el botón de continuar
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => SignUpOrSignIn(),
                                ),
                              );
                            },
                            title: 'CONTINUAR',
                            height: 45,
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
      ),
    );
  }
}

