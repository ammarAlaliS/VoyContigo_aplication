// ignore_for_file: prefer_const_constructors

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

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          _showError(state.errorMessage!);
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: isLoading,
            child: Container(

              decoration: _buildBoxDecoration(isDarkMode),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfoHeader(
                          context, state, constraints, isDarkMode),
                      _buildRowCard(context, isDarkMode)
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

  Widget _buildRowCard(BuildContext context, bool isDarkMode) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildUserMessage(isDarkMode),
            const SizedBox(height: 16),
            _buildActionButtons(isDarkMode),
          ],
        ));
  }

  BoxDecoration _buildBoxDecoration(bool isDarkMode) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: isDarkMode ? Colors.black45 : Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
     gradient: LinearGradient(
  colors: isDarkMode
      ? [Colors.white, const Color.fromARGB(255, 0, 174, 255)]
      : [
          const Color.fromARGB(255, 219, 255, 238),
          const Color.fromARGB(255, 0, 174, 255)
        ],
  begin: Alignment.topCenter, // Cambiado a topCenter
  end: Alignment.bottomCenter, // Cambiado a bottomCenter
),

      border: Border(
        bottom: BorderSide(
          // Corrección aquí
          width: 1, // Ancho del borde
          color: isDarkMode ? Colors.white : Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildUserInfoHeader(BuildContext context, UserState state,
      BoxConstraints constraints, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          _buildUserAvatar(state.profileImgUrl, constraints, isDarkMode),
          const SizedBox(width: 16),
          _buildUserDetails(state, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(
      String profileImgUrl, BoxConstraints constraints, bool isDarkMode) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: constraints.maxWidth * 0.1,
        backgroundColor:
            isDarkMode ? Colors.black : Color.fromARGB(255, 62, 208, 150),
        child: CircleAvatar(
          radius: constraints.maxWidth * 0.1,
          backgroundImage: NetworkImage(
            profileImgUrl.isNotEmpty
                ? 'https://profile-images.xing.com/images/f7bcfb36bcdf05a44974b852be4e607e-1/ammar-ali.1024x1024.jpg'
                : 'https://profile-images.xing.com/images/f7bcfb36bcdf05a44974b852be4e607e-1/ammar-ali.1024x1024.jpg',
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetails(UserState state, bool isDarkMode) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "¡Hola, ${state.firstName}!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 2),
          AutoSizeText(
            "Rol: ${state.role.toString().split('.').last}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white70 : Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AutoSizeText(
        "¿Listo para tu próximo viaje? Elige tu conductor y tu asiento. Viajar a distintos puntos nunca fue tan fácil.",
        style: TextStyle(
          fontSize: 16,
          color:
              isDarkMode ? Colors.white : const Color.fromARGB(255, 44, 44, 44),
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 10, bottom: 10, left: 10),
      child: Row(
        children: [
          _buildButton(
            "Buscar Viaje",
            isDarkMode ? Color.fromARGB(255, 0, 114, 237) : Colors.black,
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage())),
          ),
          const SizedBox(width: 10),
          _buildButton(
            "Mis viajes",
            Colors.black,
            () {
              // Acción del botón Mis viajes
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        height: 35,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          onPressed: onPressed,
          child: AutoSizeText(
            text,
            style: const TextStyle(
                fontSize: 14,
                height: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
