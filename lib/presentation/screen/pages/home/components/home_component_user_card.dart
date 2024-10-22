import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/core/configs/assets/app_images.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/pages/api/get_user_data.dart';
import 'package:quickcar_aplication/presentation/screen/pages/search/search_page.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeComponentUserCard extends StatefulWidget {
  const HomeComponentUserCard({super.key});

  @override
  _HomeComponentUserCardState createState() => _HomeComponentUserCardState();
}

class _HomeComponentUserCardState extends State<HomeComponentUserCard> {
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

    return BlocListener<UserCubit, UserState>(
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [Colors.white, const Color.fromARGB(255, 0, 174, 255)]
                      : [Colors.white, const Color.fromARGB(255, 0, 174, 255)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black45 : Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(width: 1, color: isDarkMode ? Colors.white : Colors.black.withOpacity(0.2) )
              ),
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: constraints.maxWidth * 0.1,
                              backgroundColor: isDarkMode ? Colors.black : Color.fromARGB(255, 62, 208, 150),
                              child: CircleAvatar(
                                radius: constraints.maxWidth * 0.09,
                                backgroundImage: NetworkImage(
                                  state.profileImgUrl.isNotEmpty
                                      ? state.profileImgUrl
                                      : 'https://via.placeholder.com/150',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "¡Hola, ${state.firstName}!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                AutoSizeText(
                                  "Rol: ${state.role.toString().split('.').last}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white70 : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AutoSizeText(
                        "¿Listo para tu próximo viaje? Elige tu conductor y tu asiento. Viajar a distintos puntos nunca fue tan fácil.",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    isDarkMode
                                        ? Color.fromARGB(255, 0, 114, 237)
                                        : Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SearchPage()),
                                  );
                                },
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
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  // Acción del botón Mis viajes
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
