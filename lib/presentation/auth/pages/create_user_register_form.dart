import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';

class CreateUserRegisterForm extends StatefulWidget {
  final bool isDarkMode; 
  const CreateUserRegisterForm(this.isDarkMode, {super.key});

  @override
  State<CreateUserRegisterForm> createState() => _CreateUserRegisterFormState();
}

class _CreateUserRegisterFormState extends State<CreateUserRegisterForm> {
  String _userDescription = '';
  String? _userDescriptionError;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(
          color: widget.isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10), // Espaciado interno
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Describete aqui ...',
            hintStyle: TextStyle(
              color: widget.isDarkMode
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4),
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: widget.isDarkMode
                ? Colors.white.withOpacity(0.8)
                : Colors.black.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
          maxLines: null,
          minLines: 2,
          textAlignVertical: TextAlignVertical.top,
          onChanged: (value) {
            setState(() {
              _userDescription = value;
              _userDescriptionError = null; // Limpiar errores al cambiar el texto
            });

            // Accede al Cubit y actualiza la descripción del usuario
            context.read<UserCubit>().updateUserDescription(value); // Asumiendo que tienes este método en tu Cubit
          },
        ),
      ),
    );
  }
}

