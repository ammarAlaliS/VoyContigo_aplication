import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/domain/usecases/auth/signup.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/pages/funtions/show_bottom_sheet.dart';
import 'package:quickcar_aplication/service_locator.dart';

Future<void> registerUser(BuildContext context) async {
  final userState = context.read<UserCubit>().state;

  if (_areFieldsValid(userState)) {
    try {
      // Mostrar diálogo de carga
      _showLoadingDialog(context);

      CreateUserRequest createUserRequest = CreateUserRequest(
        name: userState.firstName,
        lastName: userState.lastName,
        email: userState.email,
        password: userState.password,
      );

      // Llamar al método sign up
      var result = await sl<SignUpUseCase>().call(params: createUserRequest);

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Manejo de resultados
      result.fold(
        (failure) {
          String errorMessage = failure.toString(); // Personaliza esto si tienes un tipo específico
          _showSnackBar(context, 'Error al crear la cuenta: $errorMessage', Colors.red);
        },
        (success) {
          _showSnackBar(context, 'Cuenta creada con éxito', Colors.green);
          showBottomSheetCheck(context);
        },
      );
    } catch (error) {
      // Cerrar el diálogo de carga y mostrar error
      Navigator.of(context).pop();
      _showSnackBar(context, 'Error: $error', Colors.red);
    }
  } else {
    _showSnackBar(context, 'Por favor complete todos los campos requeridos', Colors.red);
  }
}

// Método auxiliar para mostrar un SnackBar
void _showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}

// Método auxiliar para mostrar el diálogo de carga
void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}

// Método para verificar si los campos son válidos
bool _areFieldsValid(UserState userState) {
  return userState.firstName.isNotEmpty &&
      userState.lastName.isNotEmpty &&
      userState.email.isNotEmpty &&
      userState.password.isNotEmpty;
}
