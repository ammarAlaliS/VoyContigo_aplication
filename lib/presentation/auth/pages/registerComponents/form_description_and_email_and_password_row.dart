// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_email.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_password.dart';
import 'package:quickcar_aplication/presentation/auth/common/title.dart';
import 'package:quickcar_aplication/presentation/auth/pages/create_user_register_form.dart';
import 'package:quickcar_aplication/presentation/auth/pages/registerComponents/check_and_verify_email.dart';
import 'package:quickcar_aplication/presentation/auth/pages/registerComponents/register_create_user_logic_buttom.dart';

class FormDescriptionAndEmailAndPasswordRow extends StatelessWidget {
  const FormDescriptionAndEmailAndPasswordRow({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  title: 'Agrega una descripción de ti mismo',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: CreateUserRegisterForm(isDarkMode),
                ),
                SizedBox(height: 30),
                CustomTitle(
                  title: 'Tu correo',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 20),
                RowEmail(isDarkMode: isDarkMode),
                SizedBox(height: 40),
                CustomTitle(
                  title: 'Tu contraseña',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 20),
                RowPassword(isDarkMode: isDarkMode),
                SizedBox(height: 60),
          
              ],
            ),
          ),
        );
      },
    );
  }
}
