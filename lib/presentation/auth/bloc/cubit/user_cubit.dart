import 'dart:io';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quickcar_aplication/data/models/auth/user_role.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  // Constructor de UserCubit
  UserCubit() : super(UserState());

  // Método para resetear todos los estados
  void resetState() {
    emit(UserState());
  }

  // Funciones de actualización para varios campos del usuario
  void updateFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void updateLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateProfileImgUrl(String profileImgUrl) {
    emit(state.copyWith(profileImgUrl: profileImgUrl));
  }

  void updateProfileImg(File profileImg) {
    emit(state.copyWith(profileImg: profileImg));
  }

  void updatePresentationImgUrl(String presentationImgUrl) {
    emit(state.copyWith(presentationImgUrl: presentationImgUrl));
  }

  void updatePresentationImg(File presentationImg) {
    emit(state.copyWith(presentationImg: presentationImg));
  }

  void updateUserDescription(String userDescription) {
    emit(state.copyWith(userDescription: userDescription));
  }

  void updateRole(UserRole role) {
    emit(state.copyWith(role: role));
  }

  // Método para convertir JSON a UserState
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
      role: UserRole.values.firstWhere(
        (r) => r.toString().split('.').last ==
            (json['role'] as String? ?? 'usuario'),
        orElse: () => UserRole.usuario,
      ),
    );
  }

  // Método para convertir UserState a JSON
  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'firstName': state.firstName,
      'lastName': state.lastName,
      'email': state.email,
      'password': state.password,
      'profileImgUrl': state.profileImgUrl,
      'presentationImgUrl': state.presentationImgUrl,
      'userDescription': state.userDescription,
      'role': state.role.toString().split('.').last,
    };
  }

  void updateCoverImage(String imageUrl) {
    // Implementar lógica para actualizar la imagen de portada
  }
}
