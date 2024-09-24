// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/choice_mode/pages/choice_mode.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textAnimation;
  late Animation<double> _zoomAnimation; // Asegúrate de que esto esté declarado aquí.

  @override
  void initState() {
    super.initState();

    // Configura el AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Inicia la animación hacia adelante

    // Animación para el movimiento vertical de los textos
    _textAnimation = Tween<double>(begin: 0, end: -70).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Animación para el zoom de la imagen
    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // También podrías querer reiniciar el controlador al finalizar la animación
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward(); // Repite la animación si es necesario
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Imagen de fondo con animación de zoom
            AnimatedBuilder(
              animation: _zoomAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _zoomAnimation.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImages.introImage),
                      ),
                    ),
                  ),
                );
              },
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
                    child: Center(
                      child: Column(
                        children: [
                          // Animación del texto
                          AnimatedBuilder(
                            animation: _textAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _textAnimation.value),
                                child: Text(
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
                          SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _textAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _textAnimation.value),
                                child: Text(
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
                          SizedBox(height: 20),
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
                              title: 'EMPEZAR',
                              height: 45,
                            ),
                          ),
                        ],
                      ),
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
