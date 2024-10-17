import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/models/auth/user_role.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

class Failure {
  final String message;

  Failure(this.message);
}

// Interfaz para los servicios de obtención de datos del usuario
abstract class AuthGetUserDataFirebaseServices {
  Future<Either<Failure, UserState>> getUserState(String userId);
}

// Implementación de la interfaz para obtener datos del usuario desde Firestore
class AuthGetUserDataFirebaseServicesImpl implements AuthGetUserDataFirebaseServices {
  final FirebaseFirestore firestore;

  AuthGetUserDataFirebaseServicesImpl({required this.firestore});

  @override
  Future<Either<Failure, UserState>> getUserState(String userId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await firestore.collection('users').doc(userId).get();

        if (userDoc.exists) {
          final data = userDoc.data()!;
          final userInfo = UserState(
            firstName: data['firstName'] ?? '',
            lastName: data['lastName'] ?? '',
            email: data['email'] ?? '',
            profileImgUrl: data['profileImgUrl'] ?? '',
            presentationImgUrl: data['presentationImgUrl'] ?? '',
            userDescription: data['userDescription'] ?? '',
            role: UserRole.values.firstWhere(
              (r) => r.toString().split('.').last == (data['role'] ?? 'usuario'),
              orElse: () => UserRole.usuario,
            ),
          );

          return Right(userInfo);
        } else {
          return Left(Failure("No se encontraron datos para el usuario con ID: $userId"));
        }
      } else {
        return Left(Failure("No hay usuario autenticado"));
      }
    } catch (e) {
      return Left(Failure("Error al obtener los datos del usuario: ${e.toString()}"));
    }
  }
}
