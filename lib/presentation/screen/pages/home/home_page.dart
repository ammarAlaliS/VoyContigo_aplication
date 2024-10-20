// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/pages/api/get_user_data.dart';
import 'package:quickcar_aplication/presentation/screen/pages/search/search_page.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadingFetch();
  }

  Future<void> loadingFetch() async {
    var result = await getUserData();
    if (result != null) {
      context.read<UserCubit>().updateFirstName(result.firstName);
      context.read<UserCubit>().updateLastName(result.lastName);
      context.read<UserCubit>().updateEmail(result.email);
      context.read<UserCubit>().updateProfileImgUrl(result.profileImgUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching user data")),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Obtiene las dimensiones de la pantalla para ajustes responsivos
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            return Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 5, 14, 26)
                              : Colors.white,
                          border: Border.all(
                              color: theme.dividerColor.withOpacity(0.1),
                              width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black54
                                  : Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: screenWidth * 0.1,
                                    backgroundColor: isDarkMode
                                        ? Colors.black
                                        : Colors.black,
                                    child: CircleAvatar(
                                      radius: screenWidth * 0.09,
                                      backgroundImage: NetworkImage(state
                                              .profileImgUrl.isNotEmpty
                                          ? state.profileImgUrl
                                          : 'https://via.placeholder.com/150'),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    AutoSizeText(
                                      state.role.toString().split('.').last,
                                      style: TextStyle(
                                        fontSize: screenWidth *
                                            0.035, // Tamaño dinámico
                                        height: 1,
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? const Color.fromARGB(
                                                179, 255, 255, 255)
                                            : Colors.black54,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "¡Hola de nuevo!",
                                              style: TextStyle(
                                                fontSize: screenWidth *
                                                    0.045, // Ajuste dinámico
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              maxLines: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 5),
                                              child: AutoSizeText(
                                                "${state.firstName} ${state.lastName}",
                                                style: TextStyle(
                                                  fontSize: screenWidth *
                                                      0.05, // Ajuste dinámico
                                                  fontWeight: FontWeight.w900,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                maxLines: 1,
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
                                              color: Color.fromARGB(
                                                  255, 23, 112, 6),
                                            ),
                                            child: AutoSizeText(
                                              '3', // Cambia esto por la cantidad real de viajes
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth *
                                                    0.035, // Ajuste dinámico
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          AutoSizeText(
                                            "Viajes totales",
                                            style: TextStyle(
                                              fontSize: screenWidth *
                                                  0.035, // Ajuste dinámico
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? const Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  : Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Color.fromARGB(255, 0, 0, 0)
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isDarkMode
                                              ? Colors.black54
                                              : Colors.grey.withOpacity(0.3),
                                          offset: const Offset(0, 4),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: AutoSizeText(
                                        "¿Listo para tu próximo viaje en Quickcar? Elige tu conductor y tu asiento",
                                        style: TextStyle(
                                          fontSize: 15, // Ajuste automático
                                          height: 1.3,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      isDarkMode
                                                          ? Color.fromARGB(
                                                              255, 0, 114, 237)
                                                          : Color.fromARGB(255,
                                                              6, 143, 255)),
                                            ),
                                            onPressed:
                                                () {
                                                    Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SearchPage()),
                                              );
                                                }, // Acción del botón Buscar Viaje
                                            child: const AutoSizeText(
                                              "Buscar Viaje",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      isDarkMode
                                                          ? Color.fromARGB(
                                                              255, 209, 137, 4)
                                                          : Color.fromARGB(255,
                                                              209, 137, 4)),
                                            ),
                                            onPressed: () {
                                            
                                            },
                                            child: const AutoSizeText(
                                              "Mis viajes",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          },
        ),
      ),
    );
  }
}
