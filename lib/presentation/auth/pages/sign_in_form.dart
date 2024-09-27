// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Singin.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_page.dart';
import 'package:quickcar_aplication/presentation/root/pages/root.dart';
import 'package:quickcar_aplication/service_locator.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;
  bool isDarkMode = false;
   bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Campo de correo electrónico
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3)
                          : const Color.fromARGB(255, 5, 5, 5)
                              .withOpacity(0.3),
                      width: 1.0,
                    ),
                    color: isDarkMode
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 14),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppVectors.mail,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 252, 252, 252)
                              : Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Correo electrónico',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.4),
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                                _emailError = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_emailError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      _emailError!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 5),
            // Campo de contraseña
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3)
                          : const Color.fromARGB(255, 5, 5, 5).withOpacity(0.3),
                      width: 1.0,
                    ),
                    color: isDarkMode
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 14),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppVectors.lock,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            obscureText: _obscureText, 
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.4),
                              ),
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                                _passwordError = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (_passwordError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      _passwordError!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end, 
              textBaseline: TextBaseline
                  .alphabetic, 
              children: [
                SvgPicture.asset(
                  color: Colors.cyan,
                  AppVectors.checkUser,
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.baseline, 
                  textBaseline: TextBaseline
                      .alphabetic, 
                  children: [
                    Text(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black),
                      "¿Aún no tienes cuenta en QuickCar?",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegisterPage()),
                        );
                      },
                      child: Text(
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.cyan : Colors.cyan[600]),
                        "Regístrate",
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              textBaseline:
                  TextBaseline.alphabetic,
              children: [
                SvgPicture.asset(
                  color: Colors.red,
                  AppVectors.forgotPassword,
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.baseline, 
                  textBaseline: TextBaseline
                      .alphabetic,
                  children: [
                    Text(
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black),
                      "¿Has olvidado tu contraseña?",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[600]),
                        "Recupérala",
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Validar manualmente
                  if (_email.isEmpty) {
                    setState(() {
                      _emailError = 'Por favor, ingrese su correo electrónico';
                    });
                  }
                  if (_password.isEmpty) {
                    setState(() {
                      _passwordError = 'Por favor, ingrese su contraseña';
                    });
                  }

                  if (_emailError == null && _passwordError == null) {
                    var result = await sl<SignInUseCase>().call(
                      params: CreateSignInUserRequest(
                          email: _email, password: _password),
                    );

                    result.fold(
                      (l) {
                        String errorMessage = l.toString();
                        var snackbar = SnackBar(
                          content: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Cerrar',
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        var snackbar = SnackBar(
                          content: Text(
                            r,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 241, 241, 241),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Cerrar',
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RootPage()),
                          (route) => false,
                        );
                      },
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
