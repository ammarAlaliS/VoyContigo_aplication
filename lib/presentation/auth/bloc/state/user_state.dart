import 'dart:io';
import 'package:quickcar_aplication/data/models/auth/user_role.dart';

class UserState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  final String profileImgUrl;
  final String presentationImgUrl;
  final File? presentationImg;
  final File? profileImg;

  final String userDescription;

  final UserRole role;

  final String? errorMessage;

  // Constructor
  UserState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.profileImgUrl = '',
    this.presentationImgUrl = '',
    this.userDescription = '',
    this.presentationImg,
    this.profileImg,
    this.role = UserRole.usuario,
    this.errorMessage,
  });

  // Método para copiar el estado actual y modificar campos específicos
  UserState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,

    String? profileImgUrl,
    String? presentationImgUrl,
    File? presentationImg,
    File? profileImg,

    String? userDescription,
    UserRole? role,
    bool? isLoading,
    String? errorMessage,
    
  }) {
    return UserState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      presentationImgUrl: presentationImgUrl ?? this.presentationImgUrl,
      userDescription: userDescription ?? this.userDescription,
      presentationImg: presentationImg ?? this.presentationImg,
      profileImg: profileImg ?? this.profileImg,
      role: role ?? this.role,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
