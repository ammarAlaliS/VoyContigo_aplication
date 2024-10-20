import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_buttom.dart';
import 'package:quickcar_aplication/common/widgets/warmning/basic_warmning_message.dart';
import 'package:quickcar_aplication/data/models/auth/create_upload_request.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/domain/usecases/auth/upload_image.dart';
import 'package:quickcar_aplication/domain/usecases/auth/verify_email.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_email.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_password.dart';
import 'package:quickcar_aplication/presentation/auth/common/title.dart';
import 'package:quickcar_aplication/presentation/auth/pages/create_user_register_form.dart';
import 'package:quickcar_aplication/presentation/root/pages/root.dart';
import 'package:quickcar_aplication/service_locator.dart';

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
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: CreateUserRegisterForm(isDarkMode),
                ),
                SizedBox(height: 30),
                CustomTitle(
                  title: 'Tu correo',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 20),
                RowEmail(isDarkMode: isDarkMode),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BasicWarningMessage(
                    text: 'Hemos enviado un correo electrónico para que verifiques tu cuenta en quickcar, puedes verificarla cuando desees.',
                    borderColor: const Color.fromARGB(255, 255, 166, 2),
                    bgColor: Color.fromARGB(255, 255, 166, 2).withOpacity(0.2),
                    letterHeight: 1.3,
                  ),
                ),
                SizedBox(height: 30),
                CustomTitle(
                  title: 'Tu contraseña',
                  isDarkMode: isDarkMode,
                ),
                SizedBox(height: 20),
                RowPassword(isDarkMode: isDarkMode),
                SizedBox(height: 60),
                BasicButton(
                  onPressed: () async {
                    _showLoadingDialog(context);
                    String profileImgUrl = '';
                    String presentationImgUrl = '';

                    try {
                      // Intenta subir la imagen de perfil
                      final createUploadRequestToProfileImgField = CreateUploadRequest(
                        folder: 'profile_images',
                        imageFile: userState.profileImg ?? File(''),
                      );

                      final profileImgResult = await sl<UploadImageUseCase>().call(params: createUploadRequestToProfileImgField);
                      profileImgResult.fold(
                        (error) {
                          // Manejar error, pero no detener el flujo
                          print('Error al subir imagen de perfil: $error');
                        },
                        (url) {
                          profileImgUrl = url;
                        },
                      );
                      // Intenta subir la imagen de presentación
                      final createUploadRequestToPresentationImgField = CreateUploadRequest(
                        folder: 'presentation_images',
                        imageFile: userState.presentationImg ?? File(''),
                      );

                      final presentationImgResult = await sl<UploadImageUseCase>().call(params: createUploadRequestToPresentationImgField);
                      presentationImgResult.fold(
                        (error) {
                          // Manejar error, pero no detener el flujo
                          print('Error al subir imagen de presentación: $error');
                        },
                        (url) {
                          presentationImgUrl = url;
                        },
                      );

                      // Crea la solicitud de usuario con las URLs obtenidas
                      final createUserRequest = CreateUserRequest(
                        name: userState.firstName,
                        lastName: userState.lastName,
                        email: userState.email,
                        password: userState.password,
                        role: userState.role,
                        userDescription: userState.userDescription,
                        presentationImgUrl: presentationImgUrl,
                        profileImgUrl: profileImgUrl,
                      );

                      // Llama al caso de uso para verificar el email
                      var result = await sl<VerifyEmailUseCase>().call(params: createUserRequest);
                      result.fold(
                        (failure) {
                          String errorMessage = failure.toString();
                          _showSnackBar(context, errorMessage, Colors.red);
                          Navigator.of(context).pop(); // Cerrar el diálogo de carga
                        },
                        (success) {
                          Navigator.of(context).pop(); // Cerrar el diálogo de carga
                          context.read<UserCubit>().resetState(); // Resetear el estado del cubit
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const RootPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      );
                    } catch (e) {
                      _showSnackBar(context, 'Ocurrió un error inesperado', Colors.red);
                      Navigator.of(context).pop(); // Cerrar el diálogo de carga
                    }
                  },
                  title: 'Guardar datos',
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ),
  );
}

void _showLoadingDialog(BuildContext context) {
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(isDarkMode ? Colors.white : Colors.black),
        ),
      );
    },
  );
}
