// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/warmning/basic_warmning_message.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';

// Define el widget RowEmail
class RowEmail extends StatelessWidget {
  final bool isDarkMode;
  final bool isVerified = false;

  const RowEmail({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppVectors.mail,
            color: isDarkMode ? Colors.cyan : Colors.cyan,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              userState.email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? Colors.grey
                    : Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          if (isVerified) 
            BasicWarningMessage(
              text: 'Verificado',
              borderColor: Colors.green,
              bgColor: Colors.green.withOpacity(0.2),
              letterHeight: 1.5,
            )
          else
            BasicWarningMessage(
              text: 'No verificado',
              borderColor: Colors.red,
              bgColor: Colors.red.withOpacity(0.2),
              letterHeight: 1.5,
            ),
        ],
      ),
    );
  }
}
