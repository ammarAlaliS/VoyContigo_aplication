import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/pages/sign_in_form.dart';
import 'package:quickcar_aplication/presentation/intro/set_system_color.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late AnimationController _animationTranslate;
  late Animation<double> _translationAnimation;
  bool _isTextVisible = false; // Controla la visibilidad del texto
  bool _areTermsVisible = false; // Controla la visibilidad de los términos

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
    _translationAnimation =
        Tween<double>(begin: 200, end: 0).animate(CurvedAnimation(
      parent: _animationTranslate,
      curve: Curves.easeInSine,
    ));

    // Iniciar la animación del logo
    _controller.forward().then((_) {
      setState(() {
        _isTextVisible = true;
      });

      _animationTranslate.forward().then((_) {
        setState(() {
          _areTermsVisible = true; // Los términos deben ser visibles al final
        });
      });
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

  
    return Scaffold(
      backgroundColor: scaffoldBg,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: Stack(
          children: [
            // Fondo
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
            // Contenido principal
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'INICIA SESION Y COMIENZA A CREAR EXPERIENCIAS UNICAS',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: light,
                            height: 1.2,
                            letterSpacing: -0.9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _translationAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _translationAnimation.value),
                          child: child,
                        );
                      },
                      child: SignInForm(),
                    ),
                    const SizedBox(height: 50),
                    // Términos y condiciones al final
                    AnimatedOpacity(
                      opacity: _areTermsVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "Al continuar aceptas los",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black45,
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Términos",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: isDarkMode ? Colors.cyan : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                " y la ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black45,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Política de privacidad",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: isDarkMode ? Colors.cyan : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                " de Quickcar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
