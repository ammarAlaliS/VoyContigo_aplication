import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickcar_aplication/data/models/auth/user_role.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

// Interfaz para los servicios de obtención de datos del usuario
abstract class AuthGetUserDataFirebaseServices {
  Future<Either<Exception, UserState>> getUserState(String userId);
}

class AuthGetUserDataFirebaseServicesImpl implements AuthGetUserDataFirebaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Exception, UserState>> getUserState(String userId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return Left(Exception("No hay usuario autenticado"));
      }

      final userDoc = await firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        return Left(Exception("No se encontraron datos para el usuario con ID: $userId"));
      }

      final data = userDoc.data()!;
      final userInfo = _mapDataToUserState(data);
      return Right(userInfo);
    } catch (e) {
      return Left(Exception("Error al obtener los datos del usuario: ${e.toString()}"));
    }
  }

  UserState _mapDataToUserState(Map<String, dynamic> data) {
    return UserState(
      firstName: data['firstName'] ?? 'Desconocido',
      lastName: data['lastName'] ?? 'Desconocido',
      email: data['email'] ?? 'Sin correo',
      profileImgUrl: data['profileImgUrl'] ?? '',
      presentationImgUrl: data['presentationImgUrl'] ?? '',
      userDescription: data['userDescription'] ?? 'Sin descripción',
      role: UserRole.values.firstWhere(
        (r) => r.toString().split('.').last == (data['role'] ?? 'usuario'),
        orElse: () => UserRole.usuario,
      ),
    );
  }
}


  UserState _mapDataToUserState(Map<String, dynamic> data) {
    return UserState(
      firstName: data['firstName'] ?? 'Desconocido',
      lastName: data['lastName'] ?? 'Desconocido',
      email: data['email'] ?? 'Sin correo',
      profileImgUrl: data['profileImgUrl'] ?? '',
      presentationImgUrl: data['presentationImgUrl'] ?? '',
      userDescription: data['userDescription'] ?? 'Sin descripción',
      role: UserRole.values.firstWhere(
        (r) => r.toString().split('.').last == (data['role'] ?? 'usuario'),
        orElse: () => UserRole.usuario,
      ),
    );
  }

