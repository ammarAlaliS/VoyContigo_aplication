// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/basic_app_select_theme.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/core/configs/bloc/manage_status_bar_color.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_up_or_sign_in.dart';
import 'package:quickcar_aplication/presentation/choice_mode/bloc/theme_cubit.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class ChoiceMode extends StatelessWidget {
  const ChoiceMode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.07;

    return BlocListener<StatusBarCubit, StatusBarState>(
      listener: (context, state) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: state.statusBarColor,
          systemNavigationBarColor: state.systemNavigationBarColor,
          statusBarIconBrightness: state.statusBarIconBrightness,
          systemNavigationBarIconBrightness: state.systemNavigationBarIconBrightness,
        ));
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // Imagen de fondo
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
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? Colors.white : Colors.black,
                              letterSpacing: -2,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Botón para activar el modo oscuro
                              BasicAppSelectTheme(
                                initialCircleColor: isDarkMode
                                    ? Color.fromARGB(255, 23, 23, 23)
                                    : const Color.fromARGB(255, 76, 76, 76),
                                initialIcon: SvgPicture.asset(AppVectors.moon),
                                labelText: 'Oscuro',
                                initialBorderColor: Colors.white,
                                textColor: Colors.grey,
                                onTap: () {
                                  context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                                  context.read<StatusBarCubit>().setDarkMode();
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
                                  context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                                  context.read<StatusBarCubit>().setLightMode();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SignUpOrSignIn(),
                                  ),
                                );
                              },
                              title: 'CONTINUAR',
                              height: 45,
                              backgroundColor: isDarkMode ? Color.fromARGB(255, 219, 255, 238) :  Colors.black,
                              textColor: isDarkMode ? Colors.black : Colors.white,
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
      ),
    );
  }
}
