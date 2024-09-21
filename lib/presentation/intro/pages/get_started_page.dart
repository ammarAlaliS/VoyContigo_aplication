// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/choice_mode/pages/choice_mode.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Fondo con imagen
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImages.introImage),
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
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'EL VIAJE COMIENZA AQUI',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'QuickCar es una app de transporte que conecta pasajeros con conductores y ofrece también una tienda y un blog interactivo.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
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
