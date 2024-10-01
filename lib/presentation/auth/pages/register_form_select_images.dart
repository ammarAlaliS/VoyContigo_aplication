// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_buttom.dart';
import 'package:quickcar_aplication/core/configs/assets/app_vectors.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/domain/usecases/auth/Signup.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_email.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/common/row_password.dart';
import 'package:quickcar_aplication/presentation/auth/pages/create_user_register_form.dart';
import 'package:quickcar_aplication/service_locator.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileWithCover extends StatefulWidget {
  const ProfileWithCover({super.key});

  @override
  _ProfileWithCoverState createState() => _ProfileWithCoverState();
}

class _ProfileWithCoverState extends State<ProfileWithCover> {
  File? _coverImage;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _requestGalleryPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      print("Permiso de galería concedido.");
    } else {
      print("Permiso de galería denegado.");
    }
  }

  Future<String?> _uploadImage(File imageFile, String folder) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(folder)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error al subir la imagen: $e");
      return null;
    }
  }

  Future<void> _pickCoverImage() async {
    await _requestGalleryPermission();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _coverImage = File(pickedFile.path);
      } else {
        print('No image selected for cover.');
      }
    });
  }

  Future<void> _pickProfileImage() async {
    await _requestGalleryPermission();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print('No image selected for profile.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickCoverImage,
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
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: _pickProfileImage,
                                        child: CircleAvatar(
                                          radius: 42,
                                          backgroundColor: isDarkMode ? Colors.black : Colors.white,
                                          child: _profileImage != null
                                              ? CircleAvatar(
                                                  radius: 38,
                                                  backgroundImage: FileImage(_profileImage!),
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
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Agrega una descripción de ti mismo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                letterSpacing: -1.6,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              child: CreateUserRegisterForm(isDarkMode),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Tu correo',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                letterSpacing: -1.6,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            RowEmail(isDarkMode: isDarkMode),
                            SizedBox(height: 40),
                            Text(
                              'Tu contraseña',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                letterSpacing: -1.6,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            RowPassword(isDarkMode: isDarkMode),
                            SizedBox(height: 60),
                            BasicButton(
                              onPressed: () async {
                                try {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Center(child: CircularProgressIndicator());
                                    },
                                  );

                                  final profileImgUrl = _profileImage != null
                                      ? await _uploadImage(_profileImage!, 'profile_images')
                                      : '';

                                  final presentationImgUrl = _coverImage != null
                                      ? await _uploadImage(_coverImage!, 'portal_images')
                                      : '';

                                  CreateUserRequest createUserRequest = CreateUserRequest(
                                    name: userState.firstName,
                                    lastName: userState.lastName,
                                    email: userState.email,
                                    password: userState.password,
                                    profileImgUrl: profileImgUrl ?? '',
                                    presentationImgUrl: presentationImgUrl ?? '',
                                    userDescription: userState.userDescription,
                                    role: userState.role,
                                  );

                                  var result = await sl<SignUpUseCase>().call(params: createUserRequest);
                                  Navigator.of(context).pop();

                                  result.fold((failure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error al crear la cuenta: ${failure.message}'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }, (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Cuenta creada con éxito'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(context, '/home');
                                  });
                                } catch (error) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $error'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              title: "Crear cuenta",
                              height: 50,
                              icon: Icons.mail,
                            ),
                          ],
                        ),
                      ),
                    ),
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
