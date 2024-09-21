// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class ChoiceMode extends StatelessWidget {
  const ChoiceMode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    final textSecundary = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Fondo con imagen
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.choiceMode),
                ),
              ),
            ),
            // Capa con opacidad (detrás de los elementos)
            Container(
              color: Colors.black.withOpacity(0.50),
            ),
            // Elementos que deben estar por encima
            Padding(
              padding: const EdgeInsets.only(right: 0, bottom: 120, left: 0),
              child: Column(
                children: [
                  // Aplica el desenfoque solo al contenedor del logo
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 3.0),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 20, right: 40, bottom: 20, left: 40),
                        child: Logo(),
                      ),
                    ),
                  ),

                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Elige el modo',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: textColor,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    ClipOval(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF30393C).withOpacity(0.5),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2), // Color del borde
                                              width: 1.0, // Ancho del borde
                                              style: BorderStyle.solid, // Estilo del borde
                                            ),
                                          ),
                                           child: SvgPicture.asset(
                                            AppVectors.moon,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Modo Oscuro',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textSecundary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    ClipOval(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF30393C).withOpacity(0.5),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2), // Color del borde
                                              width: 1.0, // Ancho del borde
                                              style: BorderStyle.solid, // Estilo del borde
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            AppVectors.sun,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Modo Claro',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textSecundary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChoiceMode(), // Cambiado aquí
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
