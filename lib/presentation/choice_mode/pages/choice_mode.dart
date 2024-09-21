// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/common/widgets/basic_app_select_theme.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
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
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.choiceMode),
                ),
              ),
            ),
            // Semi-transparent overlay
            Container(
              color: Colors.black.withOpacity(0.50),
            ),
            // Elements above
            Padding(
              padding: const EdgeInsets.only(right: 0, bottom: 120, left: 0),
              child: Column(
                children: [
                  // Logo with blur effect
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
                        Text(
                          'Seleccione un modo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BasicAppSelectTheme(
                              initialCircleColor: isDarkMode
                                  ? Color.fromARGB(255, 76, 76, 76) 
                                  : Color.fromARGB(255, 255, 97, 6),
                              initialIcon: SvgPicture.asset(AppVectors.moon),
                              labelText: 'Oscuro',
                              initialBorderColor: Colors.white,
                              textColor: Colors.grey,
                              onTap: () {},
                            ),
                            const SizedBox(width: 40),
                            BasicAppSelectTheme(
                              initialCircleColor: isDarkMode
                                  ? Color.fromARGB(255, 255, 97, 6) 
                                  : Color.fromARGB(255, 76, 76, 76),
                              initialIcon: SvgPicture.asset(AppVectors.sun),
                              labelText: 'Claro',
                              initialBorderColor: Colors.white,
                              textColor: Colors.grey,
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                         Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => ChoiceMode(), 
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
