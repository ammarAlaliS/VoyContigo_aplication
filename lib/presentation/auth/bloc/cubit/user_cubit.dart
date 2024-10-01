import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(UserState());

  // Actualizar nombre
  void updateFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  // Actualizar apellido
  void updateLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  // Actualizar email
  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  // Actualizar contraseña
  void updatePassword(String password) {
    emit(state.copyWith(password: password)); // Añadido
  }

  // Actualizar URL de la imagen de perfil
  void updateProfileImgUrl(String profileImgUrl) {
    emit(state.copyWith(profileImgUrl: profileImgUrl));
  }

  // Actualizar URL de la imagen de presentación
  void updatePresentationImgUrl(String presentationImgUrl) {
    emit(state.copyWith(presentationImgUrl: presentationImgUrl));
  }

  // Actualizar descripción del usuario
  void updateUserDescription(String userDescription) {
    emit(state.copyWith(userDescription: userDescription));
  }

  // Actualizar rol
  void updateRole(String role) {
    emit(state.copyWith(role: role));
  }

  @override
  UserState fromJson(Map<String, dynamic> json) {
    return UserState(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '', 
      profileImgUrl: json['profileImgUrl'] as String? ?? '',
      presentationImgUrl: json['presentationImgUrl'] as String? ?? '',
      userDescription: json['userDescription'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
    );
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'firstName': state.firstName,
      'lastName': state.lastName,
      'email': state.email,
      'password': state.password, // Añadido
      'profileImgUrl': state.profileImgUrl,
      'presentationImgUrl': state.presentationImgUrl,
      'userDescription': state.userDescription,
      'role': state.role,
    };
  }
}
