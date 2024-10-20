// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/pages/registerComponents/register_create_user_logic_buttom.dart';
import 'package:quickcar_aplication/presentation/auth/pages/register_form_select_images.dart';
import 'package:quickcar_aplication/presentation/intro/pages/congratulation_message.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellido = '';
  String _email = '';
  String _password = '';

  String? _emailError;
  String? _passwordError;
  String? _nombreError;
  String? _apellidoError;
  bool isDarkMode = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    final userCubit = context.read<UserCubit>();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Nombre",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? const Color.fromARGB(255, 252, 252, 252)
                                      : Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 30,
                                  margin: EdgeInsets.only(bottom: 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 139, 139, 139),
                                        width: 2,
                                      ),
                                      bottom: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 139, 139, 139),
                                        width: 1,
                                      ),
                                      right: BorderSide.none,
                                      top: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(AppVectors.user,
                                    color: Color(0xFF02EAFF)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9999),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                .withOpacity(0.3)
                                            : const Color.fromARGB(255, 5, 5, 5)
                                                .withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                      color: isDarkMode
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 16),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Nombre',
                                          hintStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white.withOpacity(0.4)
                                                : Colors.black.withOpacity(0.4),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                        onChanged: (value) {
                                          setState(() {
                                            _nombre = value;
                                            _nombreError = null;
                                          });
                                          userCubit.updateFirstName(_nombre);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      if (_nombreError != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            _nombreError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Apellido",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? const Color.fromARGB(255, 252, 252, 252)
                                      : Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 30,
                                  margin: EdgeInsets.only(bottom: 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 139, 139, 139),
                                        width: 2,
                                      ),
                                      bottom: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 139, 139, 139),
                                        width: 1,
                                      ),
                                      right: BorderSide.none,
                                      top: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(AppVectors.user,
                                    color: Color(0xFF02EAFF)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9999),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                .withOpacity(0.3)
                                            : const Color.fromARGB(255, 5, 5, 5)
                                                .withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                      color: isDarkMode
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 16),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Apellido',
                                          hintStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white.withOpacity(0.4)
                                                : Colors.black.withOpacity(0.4),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                        onChanged: (value) {
                                          setState(() {
                                            _apellido = value;
                                            _apellidoError = null;
                                          });
                                          userCubit.updateLastName(_apellido);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      if (_apellidoError != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            _apellidoError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Correo electronico",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? const Color.fromARGB(255, 252, 252, 252)
                                : Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 30,
                            margin: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                              ),
                              border: Border(
                                left: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  width: 1,
                                ),
                                right: BorderSide.none,
                                top: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SvgPicture.asset(AppVectors.mail,
                              color: Color(0xFF02EAFF)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 16),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Ingresa tu email',
                                    hintStyle: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white.withOpacity(0.4)
                                          : Colors.black.withOpacity(0.4),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
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
                                    userCubit.updateEmail(_email);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
            SizedBox(height: 15),
            // Campo de contraseña
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Contraseña",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? const Color.fromARGB(255, 252, 252, 252)
                                : Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 30,
                            margin: EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                              ),
                              border: Border(
                                left: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 139, 139, 139),
                                  width: 1,
                                ),
                                right: BorderSide.none,
                                top: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SvgPicture.asset(
                            AppVectors.lock,
                            color: Color(0xFF02EAFF),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
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
                                padding: const EdgeInsets.only(left: 16, right: 4),
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
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
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
                                     userCubit.updatePassword(_password);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (_nombre.isEmpty) {
                    setState(() {
                      _nombreError = 'Su nombre es requerido';
                    });
                  }
                  if (_apellido.isEmpty) {
                    setState(() {
                      _apellidoError = 'Su apellido es requerido';
                    });
                  }
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

                  if (_emailError == null &&
                      _passwordError == null &&
                      _nombreError == null &&
                      _apellidoError == null) {
                    bool success = await registerUser(context);
                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const CongratulationMessage()),
                      );
                    }
                  }
                }
              },
              child: const Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
