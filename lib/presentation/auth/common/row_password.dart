// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcar_aplication/common/widgets/warmning/basic_warmning_message.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';

// Define el widget RowPassword
class RowPassword extends StatefulWidget {
  final bool isDarkMode;

  const RowPassword({
    super.key,
    required this.isDarkMode,
  });

  @override
  _RowPasswordState createState() => _RowPasswordState();
}

class _RowPasswordState extends State<RowPassword> {
  bool isPasswordVisible = false; // Cambia esto a un estado

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
            AppVectors.lock,
            color: widget.isDarkMode ? Colors.cyan : Colors.cyan,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              isPasswordVisible ? userState.password : '*************',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.grey : Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible; 
              });
            },
            child: BasicWarningMessage(
              text: isPasswordVisible ? 'Ocultar' : 'Mostrar',
              borderColor: isPasswordVisible ? Colors.green : (widget.isDarkMode ? Colors.white : Colors.green),
              bgColor: isPasswordVisible ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
