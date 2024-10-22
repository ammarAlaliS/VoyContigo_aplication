import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/choice_mode/pages/choice_mode.dart';
import 'package:quickcar_aplication/presentation/intro/set_system_color.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _textAnimation;
  late final Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();

    // Configuración del AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Inicia la animación

    // Animación de movimiento vertical para los textos
    _textAnimation = Tween<double>(begin: 0, end: -70).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Animación de zoom para la imagen
    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Asegurar que tanto la barra de estado como la barra de navegación sean transparentes
    setSystemUIOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    );

    return Scaffold(
      extendBody: true, // Asegura que el contenido se extienda detrás de la barra de navegación
      extendBodyBehindAppBar: true, // Permite que el cuerpo de la aplicación esté detrás de la barra de estado
      body: Stack(
        children: [
          // Imagen de fondo con animación de zoom
          AnimatedBuilder(
            animation: _zoomAnimation,
            builder: (_, __) {
              return Transform.scale(
                scale: _zoomAnimation.value,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(AppImages.road),
                    ),
                  ),
                ),
              );
            },
          ),
          // Capa con opacidad
          Container(color: Colors.black.withOpacity(0.1)),
          // Contenido principal
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo con efecto de desenfoque
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Logo(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Animación de textos
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (_, __) {
                          return Transform.translate(
                            offset: Offset(0, _textAnimation.value),
                            child: const Text(
                              'EL VIAJE COMIENZA AQUI',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (_, __) {
                          return Transform.translate(
                            offset: Offset(0, _textAnimation.value),
                            child: const Text(
                              'QuickCar es una app de transporte que conecta pasajeros con conductores y ofrece también una tienda y un blog interactivo.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // Botón para comenzar
                      BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChoiceMode(),
                            ),
                          );
                        },
                        title: 'EMPEZAR',
                        height: 45,
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
