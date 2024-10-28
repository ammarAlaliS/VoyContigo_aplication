// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_form.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<RegisterPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late AnimationController _animationTranslate;
  late Animation<double> _translationAnimation;
  bool _isTextVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationTranslate = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _translationAnimation = Tween<double>(begin: 200, end: 0).animate(CurvedAnimation(
      parent: _animationTranslate,
      curve: Curves.easeInSine,
    ));
    _controller.forward().then((_) {
      setState(() {
        _isTextVisible = true;
      });
      _animationTranslate.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationTranslate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final light = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final isDarkMode = theme.brightness == Brightness.dark;

        // Obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Ajustar los tamaños de fuente basados en el ancho de la pantalla
    double titleFontSize = screenWidth * 0.07; // 6% del ancho de la pantalla
    double subtitleFontSize = screenWidth * 0.044; // 4.5% del ancho de la pantalla

    return Scaffold(
      backgroundColor: scaffoldBg,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
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
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                AppVectors.topPattern,
                color: isDarkMode
                    ? Colors.cyan
                    : const Color.fromARGB(255, 4, 4, 4),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                AppVectors.buttomPattern,
                color: isDarkMode
                    ? Colors.cyan
                    : const Color.fromARGB(255, 4, 4, 4),
              ),
            ),
          
            Column(
              mainAxisSize: MainAxisSize.min, 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        transform: Matrix4.translationValues(_animation.value, 0, 0),
                        child: child,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 219, 255, 238),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                    child: Logo(),
                  ),
                SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _isTextVisible ? _opacityAnimation.value : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    'Antes de comenzar, ingresa tu información',
                   style: TextStyle(
                          fontSize: titleFontSize, 
                          fontWeight: FontWeight.w800,
                          color: light,
                          letterSpacing: -2),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _translationAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _translationAnimation.value),
                      child: child,
                    );
                  },
                  child: RegisterForm(),
                ),
              
              ],
            ),
          ],
        ),
      ),
    );
  }
}
