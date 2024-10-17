// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Cargar datos del usuario cuando la página se inicializa
      final userCubit = BlocProvider.of<UserCubit>(context);
      userCubit.loadUserData(user.uid);
      print(user.uid); // Cambiado de user.id a user.uid
    } else {
      print('Error: No hay un usuario autenticado');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.firstName.isNotEmpty && state.lastName.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Color.fromARGB(255, 5, 14, 26) : Colors.white,
                          border: Border.all(color: theme.dividerColor.withOpacity(0.1), width: 1),
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
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundColor: isDarkMode ? Colors.black : Colors.white,
                                    child: CircleAvatar(
                                      radius: 38,
                                      backgroundImage: NetworkImage(state.profileImgUrl),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "Role:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkMode ? Colors.white : Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      state.role.toString().split('.').last,
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? const Color.fromARGB(179, 255, 255, 255)
                                            : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "¡Hola de nuevo!",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode ? Colors.white : Colors.black,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                              child: Text(
                                                "${state.firstName} ${state.lastName}", // Usa nombres del estado
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900,
                                                  color: isDarkMode ? Colors.white : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.cyan,
                                            ),
                                            child: const Text(
                                              '3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Viajes totales",
                                            style: TextStyle(
                                              fontSize: 14,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? const Color.fromARGB(255, 255, 255, 255)
                                                  : Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode ? Color.fromARGB(255, 0, 0, 0) : Colors.white,
                                      border: Border.all(color: Colors.grey, width: 1),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "¿Listo para tu próximo viaje en Quickcar? Elige tu conductor y tu asiento",
                                            style: TextStyle(
                                              fontSize: 15,
                                              height: 1.3,
                                              fontWeight: FontWeight.w500,
                                              color: isDarkMode ? Colors.white70 : Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(isDarkMode
                                                  ? Color.fromARGB(255, 1, 247, 255)
                                                  : Color.fromARGB(255, 6, 143, 255)),
                                            ),
                                            onPressed: () {}, // Define tu función onPressed aquí
                                            child: Text(
                                              "Buscar Viaje",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? const Color.fromARGB(255, 13, 13, 13)
                                                    : const Color.fromARGB(255, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(
                                                  Color.fromARGB(255, 255, 201, 4)),
                                            ),
                                            onPressed: () {}, // Define tu función onPressed aquí
                                            child: Text(
                                              "Mis Viajes",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? const Color.fromARGB(255, 0, 0, 0)
                                                    : Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Error loading user data"));
            }
          },
        ),
      ),
    );
  }
}
