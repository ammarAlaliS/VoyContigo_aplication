// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singout.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_in_page.dart';
import 'package:quickcar_aplication/presentation/choice_mode/bloc/theme_cubit.dart';
import 'package:quickcar_aplication/service_locator.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Notificaciones',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Notificación ${index + 1}'),
                      subtitle: Text('Descripción de la notificación'),
                      leading: const Icon(Icons.notifications),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCloseSessionModal(BuildContext context) {
    try {
      print("Showing close session modal"); // Debugging statement
      showDialog(
        context: context,
        barrierDismissible:
            true, // Permite cerrar el diálogo al tocar fuera de él
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Fondo oscuro y difuminado
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pop(); // Cierra el diálogo al tocar fuera
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5.0, sigmaY: 5.0), // Aplicando blur
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.5), // Color oscuro semi-transparente
                    ),
                  ),
                ),
              ),
              // Contenido del diálogo
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Icono de advertencia
                      SvgPicture.asset(
                        AppVectors.alert,
                        height: 60,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 10),
                      // Título
                      Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Mensaje
                      Text(
                        '¿Estás seguro de que deseas cerrar sesión?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Botones de acción
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.black,
                              ),
                              child: Text(
                                'Cancelar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                var result = await sl<SignoutUseCase>().call();

                                result.fold(
                                  (exception) {
                                    print("Error: ${exception.toString()}");
                                  },
                                  (value) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.black,
                              ),
                              child: Text(
                                'Cerrar sesión',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error showing modal: $e"); // Debugging statement
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ?[
                    const Color.fromARGB(255, 29, 151, 31),
                    const Color.fromARGB(255, 16, 34, 18),
                    const Color.fromARGB(255, 29, 151, 31)
                  ]
                : [
                    const Color.fromARGB(255, 0, 0, 0),
                    const Color.fromARGB(255, 16, 34, 18),
                    const Color.fromARGB(255, 0, 0, 0)
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: AppBar(
              toolbarHeight: 80,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "VoyContigo",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize:
                          math.max(screenWidth * 0.04, screenWidth * 0.06),
                      color: isDarkMode
                          ? const Color(0xFF02EAFF)
                          : Color.fromARGB(255, 255, 170, 86),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ThemeCubit>().updateTheme(
                            isDarkMode ? ThemeMode.light : ThemeMode.dark);
                      },
                      child: Stack(alignment: Alignment.topRight, children: [
                        Container(
                          width: 40,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode
                                ? Color.fromARGB(255, 39, 70, 72)
                                : Color.fromARGB(255, 39, 70, 72),
                            border: Border.all(
                              color: theme.dividerColor.withOpacity(0.06),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode
                                    ? Colors.black54
                                    : Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              isDarkMode
                                  ? FontAwesomeIcons.sun
                                  : FontAwesomeIcons.moon,
                              color: isDarkMode
                                  ? Colors.yellow[800]
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showNotifications(context),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 40,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode
                                  ? Color.fromARGB(255, 39, 70, 72)
                                  : Color.fromARGB(255, 39, 70, 72),
                              border: Border.all(
                                color: theme.dividerColor.withOpacity(0.06),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Colors.black54
                                      : Colors.black.withOpacity(0.05),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications,
                                color: isDarkMode
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showCloseSessionModal(context),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 40,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode
                                  ? Color.fromARGB(182, 255, 0, 0)
                                  : Color.fromARGB(182, 255, 0, 0),
                              border: Border.all(
                                color: theme.dividerColor.withOpacity(0.06),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Colors.black54
                                      : Colors.black.withOpacity(0.05),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppVectors.out,
                                color: isDarkMode
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
