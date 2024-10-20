// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_form_select_images.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class CongratulationMessage extends StatefulWidget {
  const CongratulationMessage({super.key});

  @override
  State<CongratulationMessage> createState() => _CongratulationMessageState();
}

class _CongratulationMessageState extends State<CongratulationMessage>
    with TickerProviderStateMixin {
  late ConfettiController _controller;
  late AnimationController _textAnimationController;
  late Animation<double> _textScaleAnimation;
  late AnimationController _colorAnimationController;
  late Animation<double> _colorAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  late AnimationController _controller2;
  late Animation<double> _animation; // Animación de deslizamiento
  late AnimationController _logoAnimationController; // Controlador para el logo

  @override
  void initState() {
    super.initState();

    // Controlador de confeti
    _controller = ConfettiController(duration: const Duration(seconds: 5));
    _controller.play();

    // Controlador para la animación de deslizamiento
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

    // Controlador para la animación de texto
    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animación de escala
    _textScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Controlador para la animación de color
    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animación de color
    _colorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _colorAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Controlador para la animación de fade
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animación de fade
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    // Controlador para el deslizamiento
    _slideController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Animación de deslizamiento
    _slideAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.linear,
      ),
    );

    // Controlador para la animación del logo
    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Iniciar animaciones
    _textAnimationController.forward();
    _colorAnimationController.forward();
    _controller2.forward(); // Iniciar la animación de deslizamiento

    // Iniciar la animación de fade después de que la animación de texto haya terminado
    _textAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.forward();

        // Iniciar animación del logo después de que se complete el fade
        _fadeController.addStatusListener((fadeStatus) {
          if (fadeStatus == AnimationStatus.completed) {
            _logoAnimationController.forward();
          }
        });
      }
    });

    _slideController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textAnimationController.dispose();
    _colorAnimationController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _controller2.dispose();
    _logoAnimationController.dispose(); // Limpiar el controlador del logo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Establece el color de fondo directamente según el modo
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor, // Establecer el color del Scaffold
        body: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  Positioned(
                    left: _slideAnimation.value *
                        MediaQuery.of(context).size.width,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SvgPicture.asset(
                        AppVectors.texture,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: isDarkMode
                            ? const Color.fromARGB(255, 14, 14, 14)
                            : const Color.fromARGB(255, 243, 243, 243),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ScaleTransition(
                          scale: _textScaleAnimation,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Text(
                              '¡Felicidades!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                               color: isDarkMode ? Colors.cyan : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Animación del logo
                                AnimatedBuilder(
                                  animation: _logoAnimationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _logoAnimationController.value,
                                      child: Logo(),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                ScaleTransition(
                                  scale: _textScaleAnimation,
                                  child: Text(
                                    'Has creado tu cuenta en',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                ScaleTransition(
                                  scale: _textScaleAnimation,
                                  child: Text(
                                    'Quickcar',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        BasicButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ProfileWithCover(),
                              ),
                            );
                          },
                          title: 'Continuar',
                          height: 50,
                        ),
                        SizedBox(height: 70,)
                      ],
                    ),
                  ),
                  ConfettiWidget(
                    confettiController: _controller,
                    blastDirection: 0,
                    emissionFrequency: 0.05,
                    numberOfParticles: 30,
                    gravity: 0.5,
                    colors: const [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.yellow,
                      Colors.purple,
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
