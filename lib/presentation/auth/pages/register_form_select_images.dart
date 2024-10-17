// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/pages/registerComponents/form_description_and_email_and_password_row.dart';
import 'package:quickcar_aplication/presentation/auth/pages/registerComponents/select_images.dart';

class ProfileWithCover extends StatefulWidget {
  const ProfileWithCover({super.key});

  @override
  _ProfileWithCoverState createState() => _ProfileWithCoverState();
}

class _ProfileWithCoverState extends State<ProfileWithCover> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;


    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return Column(
            children: [
              SelectImages(),
              Expanded(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      AppVectors.texture,
                      fit: BoxFit.cover,
                      color: isDarkMode
                          ? const Color.fromARGB(255, 14, 14, 14)
                          : const Color.fromARGB(255, 243, 243, 243),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        AppVectors.topPattern,
                        color: isDarkMode ? Colors.cyan : const Color.fromARGB(255, 4, 4, 4),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(
                        AppVectors.buttomPattern,
                        color: isDarkMode ? Colors.cyan : const Color.fromARGB(255, 4, 4, 4),
                      ),
                    ),
                    FormDescriptionAndEmailAndPasswordRow(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
