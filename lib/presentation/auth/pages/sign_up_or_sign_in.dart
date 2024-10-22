// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/appbar/app_bar_buttom.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_app_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_page.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_in_page.dart';
import 'package:quickcar_aplication/presentation/intro/set_system_color.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class SignUpOrSignIn extends StatelessWidget {
  const SignUpOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final white = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secudaryTextColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final isDarkMode = theme.brightness == Brightness.dark;

    setSystemUIOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor:
          isDarkMode ? Colors.black : Color.fromARGB(255, 219, 255, 238),
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDarkMode ? Brightness.dark : Brightness.dark,
    );

    // Obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Ajustar los tamaños de fuente basados en el ancho de la pantalla
    double titleFontSize = screenWidth * 0.07; // 6% del ancho de la pantalla
    double subtitleFontSize = screenWidth * 0.044; // 4.5% del ancho de la pantalla

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          SvgPicture.asset(
            AppVectors.texture,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: isDarkMode
                ? const Color.fromARGB(255, 14, 14, 14)
                : const Color.fromARGB(109, 224, 224, 224),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: AppBarButtom(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern,
              color:
                  isDarkMode ? Colors.cyan : const Color.fromARGB(255, 4, 4, 4),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.buttomPattern,
              color:
                  isDarkMode ? Colors.cyan : const Color.fromARGB(255, 4, 4, 4),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.transportImg,
              width: 250,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width:
                              150, // Asegúrate de que el ancho sea igual a la altura
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 255, 238),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            // Centra el contenido
                            child:
                                Logo(), 
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Viaja a cualquier destino',
                      style: TextStyle(
                          fontSize: titleFontSize, // Tamaño de fuente ajustable
                          fontWeight: FontWeight.w800,
                          color: white,
                          letterSpacing: -2),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Descubre nuevos destinos y vive experiencias únicas. Viaja con libertad a cualquier lugar del mundo.',
                      style: TextStyle(
                          fontSize:
                              subtitleFontSize, // Tamaño de fuente ajustable
                          fontWeight: FontWeight.w500,
                          color: secudaryTextColor,
                          letterSpacing: -0.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage(),
                                ),
                              );
                            },
                            title: 'Registrarse',
                            height: 45,
                            backgroundColor:   isDarkMode ? Color(0xFF02EAFF) : Colors.black,
                            textColor: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignInPage(),
                                ),
                              );
                            },
                            title: 'Iniciar Sesión',
                            height: 45,
                            backgroundColor:    isDarkMode ? Color(0xFF02EAFF) : Colors.black,
                              
                            textColor: isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    BasicAppButton(
                      onPressed: () {},
                      title: '¿Qué es Quickcar?',
                      height: 45,
                      textColor: isDarkMode ? Colors.black : Colors.white,
                      backgroundColor:
                          isDarkMode ? Color(0xFF02EAFF) : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
