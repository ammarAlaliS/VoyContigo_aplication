import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

class SelectImages extends StatefulWidget {
  const SelectImages({super.key});

  @override
  State<SelectImages> createState() => _SelectImagesState();
}

class _SelectImagesState extends State<SelectImages> {
  File? _coverImage;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<bool> _requestGalleryPermission() async {
    final status = await Permission.photos.request();
    if (status.isDenied) {
      print("Permiso de galería denegado.");

      return false;
    } else if (status.isPermanentlyDenied) {
      print("Permiso de galería denegado permanentemente.");
      // Informar al usuario que debe habilitar el permiso manualmente
      return false;
    }
    return status.isGranted;
  }

  Future<void> _pickImage(bool isCoverImage) async {
    final hasPermission = await _requestGalleryPermission();
    if (!hasPermission) {
      // Mostrar un mensaje al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permiso de galería es necesario para seleccionar imágenes.")),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isCoverImage) {
          _coverImage = File(pickedFile.path);
          context.read<UserCubit>().updatePresentationImg(_coverImage!);
        } else {
          _profileImage = File(pickedFile.path);
          context.read<UserCubit>().updateProfileImg(_profileImage!);
        }
      });
    } else {
      // Manejar cuando no se selecciona ninguna imagen
      print("No se seleccionó ninguna imagen.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se seleccionó ninguna imagen.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _pickImage(true),
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: _coverImage != null
                    ? Image.file(
                        _coverImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : userState.presentationImg != null
                        ? Image.file(
                            userState.presentationImg!,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.camera_alt, size: 50, color: Colors.grey),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 100,
                    color: Colors.black.withOpacity(0.4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: GestureDetector(
                              onTap: () => _pickImage(false),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundColor: isDarkMode ? Colors.black : Colors.white,
                                    child: _profileImage != null
                                        ? CircleAvatar(
                                            radius: 38,
                                            backgroundImage: FileImage(_profileImage!),
                                          )
                                        : userState.profileImg != null
                                            ? CircleAvatar(
                                                radius: 38,
                                                backgroundImage: FileImage(userState.profileImg!),
                                              )
                                            : Icon(Icons.camera_alt, size: 30, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${userState.firstName} ${userState.lastName}',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
