import 'package:quickcar_aplication/data/models/auth/user_role.dart';

class CreateUserRequest {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String profileImgUrl; 
  final String presentationImgUrl; 
  final String userDescription;
  final UserRole role; 

  CreateUserRequest({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    this.profileImgUrl = '', 
    this.presentationImgUrl = '',
    this.userDescription = '',
    this.role = UserRole.usuario,
  });
}
